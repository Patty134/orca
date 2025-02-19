import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:orca/firebase_options.dart';
import 'package:orca/logic/bloc/splash_bloc.dart';
import 'package:orca/logic/dependancies.dart';
import 'package:orca/pages/main_page.dart';
import 'package:sqflite/sqflite.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize the sqflite database
  final databasesPath = await getDatabasesPath();
  final path = '$databasesPath/demo.db';

  // Open the database
  await openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    // Create tables
    await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');
  });
  runApp(const MyApp());
  DependancyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..appStart(),
      child: ProviderScope(
        child: GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
            useMaterial3: true,
          ),
          home: MainPage(),
          //home: HomePage2(),
        ),
      ),
    );
  }
}
