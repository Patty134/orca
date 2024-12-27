import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orca/data/model/userManager.dart';

class AuthProvider extends StateNotifier<UserManager> {
  AuthProvider() : super(UserManager(name: "", email: "", password: ""));
  final _firebase = FirebaseAuth.instance;
  Future<Map<String, dynamic>> signUp(
      String email, String name, String password, BuildContext context) async {
    try {
      await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("signup success")));
      return {"state": "success"};
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      return {"state": "fail"};
    }
  }

  Future<Map<String, dynamic>> signIn(
      String email, String password, BuildContext context) async {
    try {
      print(email);
      print(password);
      await _firebase.signInWithEmailAndPassword(
          email: email, password: password);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Login success")));
      return {"state": "success"};
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
      return {"state": "fail"};
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await _firebase.signOut();

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("signOut success")));
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
