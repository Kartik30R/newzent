import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:newzent/model/user/user_model.dart';
import 'package:newzent/view_model/controllers/user_preference.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  UserPreference pref = UserPreference();
  UserModel user = UserModel();
  RxList<String> interests = <String>[].obs;
  RxInt maxInterest = 0.obs;
  RxBool isPressedSignin = false.obs;

  //AUTH METHODS
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
    bool interestFetched = false;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = UserModel(
          isLogin: true,
          token: await userCredential.user!.getIdToken(),
          uid: userCredential.user!.uid);
      pref.saveUser(user);
      interestFetched = await fetchInterests();
      pref.saveInterest(interests.toList());

      print("interest fetched $interestFetched in login");

      return interestFetched;
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
      return interestFetched;
    }
  }

  Future<void> logOut() async {
    await auth.signOut();
    pref.deleteInterest();
    pref.removeUser();
    interests.clear();
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

//INTERESTS METHOD
  Future<bool> fetchInterests() async {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').doc(currentUser.uid).get();
      Map<String, dynamic>? userData = snapshot.data();
      if (userData != null && userData['interests'] != null) {
        interests.assignAll(List<String>.from(userData['interests']));
        print("$interests  in function");
        return true;
      }
    }
    return false;
  }

  Future<void> updateInterests() async {
    User? currentUser = auth.currentUser;
    if (currentUser != null) {
      await firestore.collection('users').doc(currentUser.uid).set({
        'interests': interests.toList(),
      });
    }
    pref.saveInterest(interests.toList());
    print('saved  $interests');
    interests.clear();
  }

  bool isUserLoggedIn() {
    return user.isLogin ?? false;
  }
}
