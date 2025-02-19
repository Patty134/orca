import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:orca/data/model/auth.dart';
import 'package:orca/data/repositories/googleServices.dart';
import 'package:orca/data/storage/user_Data.dart';
import 'package:orca/logic/provider/auth.dart';
import 'package:orca/logic/provider/user.dart';
import 'package:orca/pages/auth/login.dart';
import 'package:orca/pages/divider/divide.dart';
import 'package:orca/pages/home/home_c.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  Future<void> loadUserTofirestore(String indentity) async {
    final userFireInstance = FirebaseFirestore.instance.collection("users");

    UserStore _userStore = UserStore();
    final userModel = await _userStore.loadData();
    userModel.identity = indentity;
    await _userStore.updateData(userModel);
    userFireInstance.doc(userModel.id).set({
      "name": userModel.name,
      "email": userModel.email,
      "phone": userModel.phone ?? "",
      "image": userModel.image ?? "",
      "id": userModel.id,
      "identity": indentity ?? "",
    });
  }

  Future<void> signUp(String name, String email, String password,
      BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .watch(authProvider.notifier)
          .signUp(email, name, password, context)
          .then((value) async {
        if (value["state"] == "success") {
          final userModel = UserModel(
            email: email,
            password: password,
            name: name,
            image: "",
            phone: "",
          );

          await ref
              .watch(userStateProvider.notifier)
              .updateDataState(userModel);

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (context.mounted) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ClassifyPage(),
                ),
              );
            }
          });
        }
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message.toString())),
      );
    }
  }

  Future<void> signIn(String email, String password, BuildContext context,
      WidgetRef ref) async {
    await ref
        .watch(authProvider.notifier)
        .signIn(email, password, context)
        .then((value) async {
      if (value["state"] == "success") {
        final userModel = UserModel(
            email: email, password: password, name: "", image: "", phone: "");
        await ref.watch(userStateProvider.notifier).updateDataState(userModel);

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          }
        });
      }
    });
  }

  Future<void> googleSignin(BuildContext context) async {
    var isAuthFirst = false;
    try {
      UserCredential data = await AuthService().signWithGoogle(
        (p0) {
          isAuthFirst = p0;
        },
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Google signin Successful")));

      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          if (isAuthFirst) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else {
            loadUserTofirestore("user");
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ClassifyPage(),
              ),
            );
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message.toString())));
    }
  }

  Future<void> _clearCachedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('preferences');
  }

  Future<void> signOut(BuildContext context, WidgetRef ref) async {
    await ref.watch(authProvider.notifier).signOut(context);
    ref.watch(userStateProvider.notifier).deleteDataState();
    await _clearCachedPreferences(); // Clear cached preferences

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
        );
      }
    });
  }
}
