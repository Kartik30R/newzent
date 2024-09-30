import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';
import 'package:newzent/view/screens/auth/interests_screen.dart';
import 'package:newzent/view_model/controllers/auth_controller.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(AppDimension().defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    ' Get the latest news right away',
                    style: Theme.of(context).textTheme.titleMedium,
                  )),
              const SizedBox(
                height: 40,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Email',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  hintText: "email",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.person),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Password',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: password,
                textInputAction: TextInputAction.done,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "password",
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(Icons.lock),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    String xemail = email.text.trim();
                    String xpassword = password.text.trim();
                    if (xemail.isEmpty || xpassword.isEmpty) {
                      print('empty fields;');
                    } else {
                      authController.isPressedSignin.value = true;
                      print(authController.isPressedSignin.value);
                      bool isSigned =
                          await authController.register(xemail, xpassword);
                      if (isSigned) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InterestsScreen(),
                          ),
                        );
                      }
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(AppColor.primary),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)))),
                  child: authController.isPressedSignin.value
                      ? const CircularProgressIndicator()
                      : Text(
                          "sign up".toUpperCase(),
                        ),
                ),
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
