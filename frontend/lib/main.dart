import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/screens/auth/Login_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'cadastro_especialista.dart';

FirebaseApp? app;

Future<void> initializeDefault() async {
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  initializeDefault();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
