import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/resources/constants/dimension/app_dimension.dart';
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
        padding:  EdgeInsets.symmetric(vertical:AppDimension().defaultMargin),
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
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilledButton(
                              onPressed: () {
                                authController.interests.add(e);
                              },
                              style: ButtonStyle(
                                shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),side: const BorderSide(color: AppColor.light))),
                                  backgroundColor: WidgetStatePropertyAll(
                                      authController.interests.contains(e)
                                          ? AppColor.primary
                                          : Colors.transparent)),
                              child: Text(e,style: const TextStyle(color: AppColor.light),),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppDimension().defaultMargin),
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: const WidgetStatePropertyAll(AppColor.primary),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)))
                  ),
                  onPressed: () {
                    authController.updateInterests();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                  },
                  child: const Text('Done')),
            )
          ],
        ),
      ),
    );
  }
}
