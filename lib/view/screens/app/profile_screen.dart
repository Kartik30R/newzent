import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/view/screens/auth/welcome_page.dart';
import 'package:newzent/view_model/controllers/auth_controller.dart';
import 'package:newzent/view_model/controllers/feed_news_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  final AuthController authController = Get.find();
  final FeedNewsController feedNewsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(user!.email ?? ''),
        ),
        ElevatedButton(
          onPressed: () async {
            await authController.logOut();
            feedNewsController.everyThingNews.clear();

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WelcomePage()),
            );
          },
          child: const Text('Log out'),
        ),
      ],
    );
  }
}
