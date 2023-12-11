import 'package:flutter/material.dart';
import 'package:stayin/auth.dart';
import 'package:stayin/screens/auth/login.dart';
import 'package:stayin/screens/admin/home.dart';
import 'package:stayin/screens/user/home.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Add loading indicator if needed
        }

        if (snapshot.hasData) {
          return FutureBuilder(
            future: Auth().getUserRole(snapshot.data!.uid),
            builder: (context, roleSnapshot) {
              if (roleSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator(); // Add loading indicator if needed
              }

              if (roleSnapshot.hasData) {
                String userRole = roleSnapshot.data as String;
                if (userRole == 'Admin') {
                  return AdminHomePage();
                } else {
                  return UserHomePage();
                }
              } else {
                return Text('Error getting user role');
              }
            },
          );
        } else {
          return LoginPage();
        }
      },
    );
  }
}
