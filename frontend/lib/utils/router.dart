import 'package:flutter/cupertino.dart';
import 'package:frontend/screens/auth/login_screen.dart';

import '../screens/auth/cadastro_especialista_screen.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String login_screen = "login_screen";
  static const String cadastro_especialist_screen =
      "cadastro_especialista_screen";

  static final routes = <String, WidgetBuilder>{
    login_screen: (BuildContext context) => const LoginScreen(),
    cadastro_especialist_screen: (BuildContext context) =>
        const CadastroTerapeuta(),
  };
}
