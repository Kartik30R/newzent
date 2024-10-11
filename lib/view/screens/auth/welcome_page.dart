import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';
import 'package:newzent/resources/constants/routes/routes.dart';
import 'package:newzent/view/screens/auth/login_screen.dart';
import 'package:newzent/view/screens/auth/sign_up.dart';
import 'package:newzent/view_model/controllers/bottom_navigation_controller.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);
  BottomNavigationController navigationController = Get.find();

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(AppDimension().defaultMargin),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  child: currentBrightness == Brightness.dark
                      ? const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.sunny,
                              size: 24, color: Colors.orangeAccent),
                        )
                      : const CircleAvatar(
                          backgroundColor: Colors.black,
                          child: Icon(Icons.nightlight_round,
                              size: 24, color: Colors.yellowAccent),
                        ),
                  onTap: () {
                    navigationController.toggleThemeMode();
                  },
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/logo.png',
                    scale: 10,
                  )),
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.getLogIn());
                      },
                      style: ButtonStyle(
                        backgroundColor: const WidgetStatePropertyAll(
                            Color.fromARGB(255, 255, 255, 255)),
                        elevation: const WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                      ),
                      child: Text(
                        "Login".toUpperCase(),
                        style: const TextStyle(color: AppColor.primary),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.getSignUp());
                      },
                      style: ButtonStyle(
                        backgroundColor:
                            const WidgetStatePropertyAll(AppColor.primary),
                        elevation: const WidgetStatePropertyAll(0),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4))),
                      ),
                      child: Text(
                        "Sign Up".toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
