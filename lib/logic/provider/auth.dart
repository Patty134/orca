import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orca/data/model/userManager.dart';

class AuthProvider extends StateNotifier<UserManager> {
  AuthProvider() : super(UserManager(name: "", email: "", password: ""));
  final _firebase = FirebaseAuth.instance;
  Future<void> signUp(
      String email, String name, String password, BuildContext context) async {
    try {
      _firebase.createUserWithEmailAndPassword(
          email: email, password: password);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("signup success")));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }
}

final authProvider = StateNotifierProvider<AuthProvider, UserManager>(
  (ref) {
    return AuthProvider();
  },
);
