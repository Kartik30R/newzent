import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/view/screens/main_screen.dart';
import 'package:newzent/view_model/controllers/auth_controller.dart';
import 'package:newzent/view_model/controllers/feed_news_controller.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});
TextEditingController email =TextEditingController();
TextEditingController password =TextEditingController();
AuthController authController= Get.find();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            onSaved: (email) {},
            decoration:  const InputDecoration(
              
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(8),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: TextFormField(
              controller: password,
              textInputAction: TextInputAction.done,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              String xemail=email.text.trim();
              String xpassword =password.text.trim();
              authController.login(xemail, xpassword);
              FeedNewsController().fetchEveryThingNews();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(),));
            },
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: 8),
         
        ],
      ),
    );
  }
}