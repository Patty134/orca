import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:orca/logic/provider/auth.dart';
import 'package:orca/pages/home/home.dart';

class AuthController extends GetxController {
  Future<void> signUp(String name, String email, String password,
      BuildContext context, WidgetRef ref) async {
    await ref
        .watch(authProvider.notifier)
        .signUp(email, name, password, context);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }
}
