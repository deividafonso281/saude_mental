import 'package:flutter/material.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:frontend/screens/search/busca_psicologo_screen.dart';
import 'package:frontend/screens/auth/login_screen.dart';
import 'package:frontend/utils/router.dart';
import 'package:provider/provider.dart';

import 'auth_builder.dart';
import 'models/user_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({required Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return AuthWidgetBuilder(
      builder: (BuildContext context, AsyncSnapshot<UserModel> userSnapshot) {
        return MaterialApp(
          routes: Routes.routes,
          home: Consumer<AuthProvider>(
            builder: (_, authProviderRef, __) {
              if (userSnapshot.connectionState == ConnectionState.active) {
                return userSnapshot.hasData &&
                        authProvider.status == Status.Authenticated
                    ? const SearchScreen()
                    : const LoginScreen();
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
