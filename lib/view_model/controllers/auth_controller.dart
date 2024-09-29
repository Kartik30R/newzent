import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:newzent/model/user/user_model.dart';
import 'package:newzent/view_model/controllers/bottom_navigation_controller.dart';
import 'package:newzent/view_model/controllers/feed_news_controller.dart';
import 'package:newzent/view_model/controllers/user_preference.dart';

class AuthController extends GetxController {
  UserPreference up = new UserPreference();
  final BottomNavigationController navigationController =
      Get.put(BottomNavigationController());
  final FeedNewsController feedNewsController = Get.put(FeedNewsController());

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserPreference pref = UserPreference();
  UserModel user = UserModel();
  RxList<String> interests = <String>[].obs;
  RxBool pressed = false.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    user = await pref.getUser();
    if (user.isLogin == true) {
      await fetchInterests(user.uid);
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await _setUserToken(userCredential);
      return true;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      String uid = userCredential.user!.uid;
      user = UserModel(
          isLogin: true,
          token: await userCredential.user!.getIdToken(),
          uid: userCredential.user!.uid);
      pref.saveUser(user);
      navigationController.currentIndex.value = 0;
      await fetchInterests(uid);
      // pref.saveInterest(interests);
      feedNewsController.fetchEveryThingNews();
      return true;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  Future<void> logOut() async {
    await auth.signOut();
    pref.removeUser();
    interests.clear();
    // pref.deleteInterest();
    feedNewsController.everyThingNews.clear();
  }

  Future<void> _setUserToken(UserCredential userCredential) async {
    User? user = userCredential.user;
    if (user != null) {
      String? token = await user.getIdToken();
      await firestore.collection('users').doc(user.uid).set({
        'token': token,
      }, SetOptions(merge: true));
    }
  }

  Future<void> fetchInterests(String? uid) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await firestore.collection('users').doc(uid).get();
    Map<String, dynamic>? userData = snapshot.data();
    if (userData != null && userData['interests'] != null) {
      interests.assignAll(List<String>.from(userData['interests']));
      print('fetched');
      // await pref.saveInterest(interests);
    }
  }

  bool isUserLoggedIn() {
    return user.isLogin ?? false;
  }

//saving the users interests at uid doc in firebase
  Future<void> updateInterests() async {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      await firestore.collection('users').doc(currentUser.uid).set({
        'interests': interests.toList(),
      });
    }
    interests.clear();
  }
}
