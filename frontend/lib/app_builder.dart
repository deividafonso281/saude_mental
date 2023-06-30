import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/especialist_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/auth/auth_provider.dart';
import 'package:frontend/screens/auth/register/register_screen.dart';
import 'package:frontend/screens/search/search_screen.dart';
import 'package:frontend/screens/auth/login_screen.dart';
import 'package:frontend/utils/router.dart';
import 'package:provider/provider.dart';

import 'auth_builder.dart';
import 'models/auth_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({required Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return AuthWidgetBuilder(
      builder: (BuildContext context, AsyncSnapshot<AuthModel> userSnapshot) {
        return MaterialApp(
          routes: Routes.routes,
          home: Consumer<AuthProvider>(
            builder: (_, authProviderRef, __) {
              if (userSnapshot.connectionState == ConnectionState.active) {
                if (userSnapshot.hasData &&
                    authProvider.status == Status.Authenticated) {
                  final userModel = Provider.of<AuthModel>(context);

                  print(" $userModel");
                  return userModel.runtimeType != EspecialistModel
                      ? const SearchScreen()
                      : const CadastroTerapeuta();
                } else {
                  return const LoginScreen();
                }
              }

              return const Material(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
      },
      key: const Key('AuthWidget'),
    );
  }
}
