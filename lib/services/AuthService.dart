import 'package:TridentAdmin/home_page.dart';
import 'package:TridentAdmin/screens/feed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.onAuthStateChanged.map((FirebaseUser user) => user?.uid);

  Future<String> uID() async {
    final FirebaseUser user = await _firebaseAuth.currentUser();
    final uid = user.uid;
    return uid;
  }

  handler() {
    return StreamBuilder<String>(
      stream: onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? Feed() : HomePage();
        }
        return Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

// SignIn
  Future<String> signIn(String email, String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .user
        .uid;
  }

  signOut() {
    _firebaseAuth.signOut();
  }

  Future<String> username() async {
    try {
      FirebaseUser user = await _firebaseAuth.currentUser();
      String name = user.displayName;
      return name;
    } catch (e) {
      print(e.message);
      return "";
    }
  }
}
