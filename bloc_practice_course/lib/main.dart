// import 'package:bloc_practice_course/bloc_example4/views/main_view.dart';
import 'package:bloc_practice_course/bloc_example1/homepage.dart';
import 'package:bloc_practice_course/cubit_example/cubit_example.dart';
import 'package:bloc_practice_course/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black26
        )
      ),
      home: const BlocExample1()
    );
  }
}