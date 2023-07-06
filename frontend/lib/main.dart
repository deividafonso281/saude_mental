import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/models/especialist_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/auth/auth_provider.dart';
import 'package:frontend/providers/database/firebase/firestore_general%20_dao.dart';
import 'package:frontend/providers/geo_services/coordinates_service.dart';
import 'package:provider/provider.dart';
import 'app_builder.dart';
import 'package:flutter/material.dart';
import 'package:search_cep/search_cep.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
