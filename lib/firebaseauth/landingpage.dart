import 'package:finezy/loginPage.dart';
import 'package:finezy/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error: ${snapshot.error}"),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    User user = snapshot.data;
                    if (user == null) {
                      return LoginPage();
                    } else {
                      return MainPage();
                    }
                  }
                  return Scaffold(
                    body: Center(
                      child: Text("Loading......."),
                    ),
                  );
                });
          }
          return Scaffold(
              body: Center(
            child: Text("Loading......."),
          ));
        });
  }
}
