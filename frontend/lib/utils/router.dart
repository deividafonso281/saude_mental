import 'package:flutter/cupertino.dart';
import 'package:frontend/screens/auth/register/intermediete_register_screen.dart';
import 'package:frontend/screens/auth/login_screen.dart';
import 'package:frontend/screens/search/search_screen.dart';
import 'package:frontend/screens/schedule/psychologist_details_screen.dart';

import '../screens/auth/register/register_screen.dart';

class Routes {
  Routes._(); //this is to prevent anyone from instantiate this object

  static const String login_screen = "login_screen";
  static const String cadastro_especialist_screen =
      "cadastro_especialista_screen";
  static const String intermediete_register_screen =
      "intermediete_register_screen";
  static const String search_screen = "search_screen";
  static const String psychologist_details_screen = "psychologist_details_screen";

  static final routes = <String, WidgetBuilder>{
    login_screen: (BuildContext context) => const LoginScreen(),
    cadastro_especialist_screen: (BuildContext context) =>
        const CadastroTerapeuta(),
    intermediete_register_screen: (BuildContext context) =>
        const IntermedieteRegisterScreen(),
    search_screen: (BuildContext context) => const SearchScreen(),
    psychologist_details_screen: (BuildContext context) => const PsyDetailsScreen(parametro1: '', parametro2: 0,),
  };
}
