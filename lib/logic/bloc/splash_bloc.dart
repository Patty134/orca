import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/logic/bloc/splash_state.dart';

class SplashBloc extends Cubit<InitialState> {
  SplashBloc() : super(SplashState());

  Future<void> appStart() async {
    await Future.delayed(Duration(seconds: 2));

    emit(AuthState());

    // emit(HomeState());
  }
}
