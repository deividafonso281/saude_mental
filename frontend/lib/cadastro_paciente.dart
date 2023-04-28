import 'package:flutter/material.dart';

class CadastroPaciente extends StatefulWidget {
  const CadastroPaciente({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<CadastroPaciente> createState() => _CadastroPacienteState();
}

class _CadastroPacienteState extends State<CadastroPaciente> {
  String _password = '';
  Color _eightchars = Colors.black;
  Color _special_caracter = Colors.black;
  Color _uppercase = Colors.black;
  Color _lowercase = Colors.black;
  Color _password_confirmation = Colors.black;

  void _validatePassword(text) {
    setState(() {
      _password = text;
      RegExp eightchar = RegExp(r'.{8}');
      RegExp uppercase = RegExp(r'.*[A-Z].*');
      RegExp lowercase = RegExp(r'.*[a-z].*');
      if (eightchar.hasMatch(text)) {
        _eightchars = Colors.green;
      }
      else if (text == ''){
        _eightchars = Colors.black;
      }
      else {
        _eightchars = Colors.red;
      }
      if (uppercase.hasMatch(text)) {
        _uppercase = Colors.green;
      }
      else if (text == ''){
        _uppercase = Colors.black;
      }
      else {
        _uppercase = Colors.red;
      }
      if (lowercase.hasMatch(text)) {
        _lowercase = Colors.green;
      }
      else if (text == ''){
        _lowercase= Colors.black;
      }
      else {
        _lowercase = Colors.red;
      }
    });
  }

  void _validatePasswordConfirmation(text) {
    setState(() {
      if (text=='') {
        _password_confirmation = Colors.black;
      }
      else if (text == _password) {
        _password_confirmation = Colors.green;
      }
      else {
        _password_confirmation = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Safe Mind"),
      ),
      body:
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        children: <Widget>[
          const TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Bairro',
            ),
          ),
          const TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Cidade',
            ),
          ),
          const TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Pais',
            ),
          ),
          const TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Complemento',
            ),
          ),
          const TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Email',
            ),
          ),
          const TextField(
            obscureText: false,
            decoration: InputDecoration(
              labelText: 'Confirmar email',
            ),
          ),
          const Text('Sua senha precisa:',textAlign: TextAlign.left,),
          Text('- Oito ou mais caracteres',textAlign: TextAlign.left, style: TextStyle(
            color: _eightchars,
          ),),
          Text('- Um ou mais caracteres especiais',textAlign: TextAlign.left,),
          Text('- Uma ou mais letras maiusculas',textAlign: TextAlign.left, style: TextStyle(
            color: _uppercase,
          ),),
          Text('- Uma ou mais letras minusculas',textAlign: TextAlign.left, style: TextStyle(
            color: _lowercase,
          ),),
          TextField(
            onChanged: (text) {
              _validatePassword(text);
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Senha',
            ),
          ),
          Text('A confirmacao precisa ser igual a senha',textAlign: TextAlign.left, style: TextStyle(
            color: _password_confirmation,
          ),),
          TextField(
            onChanged: (text) {
              _validatePasswordConfirmation(text);
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirmar senha',
            ),
          ),
          ElevatedButton(
              onPressed: (){},
              child: const Text("Cadastrar")
          )
        ],
      ),
    );
  }
}