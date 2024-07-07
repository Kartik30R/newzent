import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/view/screens/interests_screen.dart';
import 'package:newzent/view_model/controllers/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            controller: email,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(
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
            onPressed: () async {
              String xemail = email.text.trim();
              String xpassword = password.text.trim();
              await authController.register(xemail, xpassword);
              if (authController.isRegister.value) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InterestsScreen(),
                  ),
                );
              }
            },
            child: Text(
              "sign up".toUpperCase(),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
