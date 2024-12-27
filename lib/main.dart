import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:orca/firebase_options.dart';
import 'package:orca/logic/bloc/splash_bloc.dart';
//import 'package:orca/pages/auth/login.dart';
//import 'package:orca/pages/divider/divide.dart';
//import 'package:orca/pages/auth/signup.dart';
//import 'package:orca/pages/home/home_c.dart';
//import 'package:orca/pages/home/home_f.dart';
//import 'package:orca/pages/main_page.dart';
import 'package:orca/pages/splash/splash.dart';
//import 'package:orca/pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: BlocProvider(
        create: (context) => SplashBloc()..appStart(),
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
            useMaterial3: true,
          ),
          home: SplashPage(),
        ),
      ),
    );
  }
}
