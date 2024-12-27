import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:orca/data/model/auth.dart';
import 'package:orca/data/repositories/googleServices.dart';
import 'package:orca/logic/provider/auth.dart';
import 'package:orca/logic/provider/user.dart';
import 'package:orca/pages/auth/login.dart';
import 'package:orca/pages/auth/signup.dart';
import 'package:orca/pages/home/home_c.dart';

class AuthController extends GetxController {
  Future<void> signUp(String name, String email, String password,
      BuildContext context, WidgetRef ref) async {
    try {
      // Attempt to sign up the user
      await ref
          .watch(authProvider.notifier)
          .signUp(email, name, password, context)
          .then(
        (value) async {
          if (value["state"] == "success") {
            final userModel = UserModel(
                email: email,
                password: password,
                name: name,
                image: "",
                phone: "");
            await ref
                .watch(userStateProvider.notifier)
                .updateDataState(userModel);

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ));
          } else {}
        },
      );
    } on FirebaseAuthException catch (e) {
      // Show error message if sign-up fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
      // Do not navigate if there's an exception
    }
  }

  Future<void> signIn(String email, String password, BuildContext context,
      WidgetRef ref) async {
    await ref
        .watch(authProvider.notifier)
        .signIn(email, password, context)
        .then(
      (value) async {
        if (value["state"] == "success") {
          final userModel = UserModel(
              email: email, password: password, name: "", image: "", phone: "");
          await ref
              .watch(userStateProvider.notifier)
              .updateDataState(userModel);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        }
      },
    );
  }

  Future<void> googleSignin(BuildContext context) async {
    try {
      UserCredential data = await AuthService().signWithGoogle();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Google signin Successful")));

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  Future<void> signOut(BuildContext context, WidgetRef ref) async {
    await ref.watch(authProvider.notifier).signOut(context);
    ref.watch(userStateProvider.notifier).deleteDataState();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
  }
}
