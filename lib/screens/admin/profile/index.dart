import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stayin/auth.dart';

class AdminProfilePage extends StatelessWidget {
  final User? Admin;

  AdminProfilePage({required this.Admin});

  Widget _AdminUid() {
    return Text('Admin Email: ${Admin?.email ?? 'N/A'}');
  }

  Widget _signOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Auth().signOut();
        Navigator.pop(context); // Pop the profile page after signing out
      },
      child: Text('Sign Out'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Profile Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _AdminUid(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement any profile-related actions
              },
              child: Text('Edit Profile'),
            ),
            _signOutButton(context),
          ],
        ),
      ),
    );
  }
}
