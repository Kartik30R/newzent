class UserModel {
  String? uid;
  String? token;
  bool? isLogin =false;

  UserModel({this.token , this.isLogin , this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    isLogin = json['isLogin'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['isLogin'] = this.isLogin;
    data['uid'] = this.uid;
    return data;
  }
}
