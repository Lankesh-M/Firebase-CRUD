import 'package:crud/features/user_auth/presentation/pages/login_page.dart';
import 'package:crud/global/common/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Drawer',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: const Text('Sign Out'),
            onTap: () {
              FirebaseAuth.instance.signOut;
              showToast(message: "Successfully Signed Out");
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (route) => false);
            },
          ),
          ListTile(
            title: const Text('Another button'),
            onTap: () {
              // Add your functionality for Item 2
              Navigator.pop(context); // Close the drawer
            },
          ),
          // Add more ListTiles for additional items
        ],
      ),
    );
  }
}
