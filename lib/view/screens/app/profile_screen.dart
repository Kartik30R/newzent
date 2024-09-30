import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newzent/view/screens/app/main_screen.dart';
import 'package:newzent/view/screens/auth/welcome_page.dart';
import 'package:newzent/view_model/controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
   ProfileScreen({super.key});
  final User? user = FirebaseAuth.instance.currentUser;
  AuthController authController =AuthController();

  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(user!.email??''),
        ),
        ElevatedButton(onPressed: (){
          authController.logOut();
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => WelcomePage(),));

        }, child: Text('Log out'))
      ],
    );
  }
}