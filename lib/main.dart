import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/resources/theme/app_theme.dart';
import 'package:newzent/view/screens/app/main_screen.dart';
import 'package:newzent/view/screens/auth/welcome_page.dart';
import 'package:newzent/view_model/controllers/auth_controller.dart';
import 'package:newzent/view_model/controllers/bottom_navigation_controller.dart';
import 'package:newzent/view_model/controllers/feed_news_controller.dart';
import 'package:newzent/view_model/controllers/user_preference.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final BottomNavigationController navigationController = Get.put(BottomNavigationController());
  final AuthController authController = Get.put(AuthController());
    final FeedNewsController feedNewsController = Get.put(FeedNewsController());
 

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (navigationController.themeMode.value == null || authController.user == null) {
        return CircularProgressIndicator();
      }

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: navigationController.themeMode.value,
        home: authController.isUserLoggedIn() ? MainPage() : WelcomePage(),
      );
    });
  }
}
