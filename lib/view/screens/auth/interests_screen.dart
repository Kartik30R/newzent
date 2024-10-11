import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';
import 'package:newzent/resources/constants/routes/routes.dart';
import 'package:newzent/resources/constants/string/app_string.dart';
import 'package:newzent/view/screens/auth/login_screen.dart';
import 'package:newzent/view_model/controllers/auth_controller.dart';

class InterestsScreen extends StatelessWidget {
  InterestsScreen({super.key});
  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.symmetric(vertical: AppDimension().defaultMargin),
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: AppString.newsTopics
                        .map(
                          (e) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilledButton(
                              onPressed: () {
                                if (authController.interests.contains(e)) {
                                  authController.interests.remove(e);

                                  authController.maxInterest--;
                                  print(
                                      "removed   $authController.maxInterest");
                                } else {
                                  if (authController.maxInterest.value >= 5) {
                                    Get.snackbar("Limit reached",
                                        "You can choose only 5 interests",
                                        snackPosition: SnackPosition.BOTTOM);
                                  } else {
                                    authController.interests.add(e);
                                    authController.maxInterest++;
                                    print(
                                        "added   $authController.maxInterest");
                                  }
                                }
                              },
                              style: ButtonStyle(
                                  shape: WidgetStatePropertyAll(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          side: const BorderSide(
                                              color: AppColor.light))),
                                  backgroundColor: WidgetStatePropertyAll(
                                      authController.interests.contains(e)
                                          ? AppColor.primary
                                          : Colors.transparent)),
                              child: Text(
                                e,
                                style: const TextStyle(color: AppColor.light),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: AppDimension().defaultMargin),
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(AppColor.primary),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)))),
                  onPressed: () {
                    if (authController.interests.isEmpty) {
                      Get.snackbar("No Interests Selected",
                          "Please select at least one interest.",
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      authController.updateInterests();
                      Get.offNamed(AppRoutes.logIn);
                    }
                  },
                  child: const Text('Done')),
            )
          ],
        ),
      ),
    );
  }
}
