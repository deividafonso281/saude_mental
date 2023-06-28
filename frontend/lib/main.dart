import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/providers/auth/auth_provider.dart';
import 'package:frontend/providers/geo_services/coordinates_service.dart';
import 'package:provider/provider.dart';
import 'app_builder.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:search_cep/search_cep.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
