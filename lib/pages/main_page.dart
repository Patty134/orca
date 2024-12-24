import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/logic/bloc/splash_bloc.dart';
import 'package:orca/logic/bloc/splash_state.dart';
import 'package:orca/pages/auth/login.dart';
import 'package:orca/pages/auth/signup.dart';
import 'package:orca/pages/splash/splash.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashBloc, InitialState>(
      builder: (context, state) {
        if (state is SplashState) {
          return SplashPage();
        } else if (state is AuthState) {
          return Login();
        } else {
          return SplashPage();
        }
      },
    );
  }
}
