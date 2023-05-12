import 'package:flutter/material.dart';
import 'cadastro_especialista.dart';

void main() {
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
<<<<<<< HEAD
      home: const CadastroTerapeuta(title: 'Cadastro de especialista'),
=======
      home: const CadastroTerapeuta(),
>>>>>>> 5bd2b76 (My local changes)
    );
  }
}
