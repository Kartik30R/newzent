import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzent/resources/constants/color/app_color.dart';
import 'package:newzent/view/screens/auth/welcome_page.dart';
import 'package:newzent/view_model/controllers/auth_controller.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final User? user = FirebaseAuth.instance.currentUser;
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.dark,
      appBar: AppBar(
        // title: const Text('Profile'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 24),

            /// AVATAR
            CircleAvatar(
              radius: 42,
              backgroundColor: AppColor.primary,
              child: Text(
                (user?.email ?? 'U').substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// EMAIL
            Text(
              user?.email ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 32),

            /// CARD
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _ProfileTile(
                    icon: Icons.person_outline,
                    title: 'Account',
                    subtitle: 'Personal information',
                  ),
                  const Divider(height: 1),
                  _ProfileTile(
                    icon: Icons.notifications_none,
                    title: 'Notifications',
                    subtitle: 'Preferences',
                  ),
                  const Divider(height: 1),
                  _ProfileTile(
                    icon: Icons.security,
                    title: 'Privacy & Security',
                    subtitle: 'Manage your account',
                  ),
                ],
              ),
            ),

            const Spacer(),

            /// LOGOUT
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.logout),
                label: const Text('Log out'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () async {
                  await authController.logOut();
                  Get.offAll(() => WelcomePage());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// REUSABLE TILE
class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColor.primary),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
