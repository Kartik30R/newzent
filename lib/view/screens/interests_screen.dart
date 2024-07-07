import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/resources/constants/string/app_string.dart';
import 'package:newzent/view/screens/login_screen.dart';
import 'package:newzent/view_model/controllers/auth_controller.dart';

class InterestsScreen extends StatelessWidget {
  InterestsScreen({super.key});
  AuthController authController = AuthController();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Wrap(
                  children: AppString.newsTopics
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: FilledButton(
                            onPressed: () {
                              authController.interests.add(e);
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    authController.interests.contains(e)
                                        ? Colors.amber
                                        : Colors.blueAccent)),
                            child: Text(e),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                authController.updateInterests();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
              },
              child: Text('Done'))
        ],
      ),
    );
  }
}
