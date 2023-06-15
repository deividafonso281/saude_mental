import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/screens/auth/login_screen.dart';
import 'package:provider/provider.dart';
import 'app_builder.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'screens/auth/cadastro_especialista_screen.dart';

FirebaseApp? app;

Future<void> initializeDefault() async {
  app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

void main() async {
  initializeDefault();
  //WidgetsFlutterBinding.ensureInitialized();
  runApp(
    /*
      * MultiProvider for top services that do not depends on any runtime values
      * such as user uid/email.
       */
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
          create: (context) => AuthProvider(),
        ),
      ],
      child: const MyApp(
        key: Key('MyApp'),
      ),
    ),
  );
}
