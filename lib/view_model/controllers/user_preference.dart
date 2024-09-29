import 'package:get/get.dart';
import 'package:newzent/model/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreference {
  Future<bool> saveUser(UserModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', responseModel.token.toString());
    sp.setBool('isLogin', responseModel.isLogin ?? false);
    sp.setString('uid', responseModel.uid!);

    return true;
  }

// Future<bool> saveInterest(List<String> interest) async{
//         SharedPreferences sp = await SharedPreferences.getInstance();
//         sp.setStringList('interest', interest);
//         return true;

// }
// Future<List<String>> getInterest() async{
//         SharedPreferences sp = await SharedPreferences.getInstance();
//      return   sp.getStringList('interest') ??[];

// }

// Future<void> deleteInterest() async{
//         SharedPreferences sp = await SharedPreferences.getInstance();
//        sp.remove('interest') ;

// }

  Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    bool? isLogin = sp.getBool('isLogin');
    String? uid = sp.getString('uid');

    return UserModel(token: token, isLogin: isLogin, uid: uid);
  }

  Future<bool> removeUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    return true;
  }
}
