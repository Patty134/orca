import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:orca/data/storage/user_Data.dart';
import 'package:orca/logic/bloc/splash_state.dart';

class SplashBloc extends Cubit<InitialState> {
  SplashBloc() : super(SplashState());

  Future<void> appStart() async {
    UserStore userStore = await UserStore();
    final validState = await userStore.loadData();

    await Future.delayed(Duration(seconds: 2));
    if (validState.email != null && validState.email!.isNotEmpty) {
      emit(HomeState());
    } else {
      emit(AuthState());
    }

    // emit(HomeState());
  }
}
