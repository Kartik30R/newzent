import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/resources/constants/routes/routes.dart';
import 'package:newzent/resources/theme/app_theme.dart';
import 'package:newzent/view_model/controllers/auth_controller.dart';
import 'package:newzent/view_model/controllers/bottom_navigation_controller.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final AuthController authController = Get.put(AuthController());
  await authController.loadUserFromPrefs(); 

  Get.put(BottomNavigationController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AuthController authController = Get.find<AuthController>();
  final BottomNavigationController navigationController = Get.find<BottomNavigationController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: navigationController.themeMode.value,
        initialRoute: authController.isUserLoggedIn()
            ? AppRoutes.getMain()
            : AppRoutes.getWelcome(),
        getPages: AppRoutes.routes,
      );
    });
  }
}
