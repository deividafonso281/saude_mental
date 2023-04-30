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
  State<CadastroPaciente> createState() => CadastroPacienteState();
}

class CadastroPacienteState extends State<CadastroPaciente> {
  String _password = '';
  Color _eightChars = Colors.black;
  Color _specialCaracter = Colors.black;
  Color _upperCase = Colors.black;
  Color _lowerCase = Colors.black;
  Color _passwordConfirmation = Colors.black;

  int testPasswordLength(text) {
    RegExp eightChar = RegExp(r'.{8}');
    if (eightChar.hasMatch(text)) {
      return 1;
    }
    else if (text == ''){
      return 0;
    }
    else {
      return -1;
    }
  }

  int testUpperCase(text) {
    RegExp upperCase = RegExp(r'.*[A-Z].*');
    if (upperCase.hasMatch(text)) {
      return 1;
    }
    else if (text == ''){
      return 0;
    }
    else {
      return -1;
    }
  }

  int testLowerCase(text) {
    RegExp lowerCase = RegExp(r'.*[a-z].*');
    if (lowerCase.hasMatch(text)) {
      return 1;
    }
    else if (text == ''){
      return 0;
    }
    else {
      return -1;
    }
  }

  int testSpecialCaracters(text) {
    RegExp especialCaracters = RegExp(r'.*[!@#\$&*~].*');
    if (especialCaracters.hasMatch(text)) {
      return 1;
    }
    else if (text == ''){
      return 0;
    }
    else {
      return -1;
    }
  }

  void _validatePassword(text) {
    setState(() {
      _password = text;

      if (testPasswordLength(text) == 1) {
        _eightChars = Colors.green;
      }
      else if (testPasswordLength(text) == 0) {
        _eightChars = Colors.black;
      }
      else {
        _eightChars = Colors.red;
      }

      if (testUpperCase(text)==1) {
        _upperCase = Colors.green;
      }
      else if (testUpperCase(text)==0){
        _upperCase = Colors.black;
      }
      else {
        _upperCase = Colors.red;
      }

      if (testLowerCase(text)==1) {
        _lowerCase = Colors.green;
      }
      else if (testLowerCase(text)==0){
        _lowerCase = Colors.black;
      }
      else {
        _lowerCase = Colors.red;
      }

      if (testSpecialCaracters(text)==1) {
        _specialCaracter = Colors.green;
      }
      else if (testLowerCase(text)==0){
        _specialCaracter = Colors.black;
      }
      else {
        _specialCaracter = Colors.red;
      }
    });
  }

  void _validatePasswordConfirmation(text) {
    setState(() {
      if (text=='') {
        _passwordConfirmation = Colors.black;
      }
      else if (text == _password) {
        _passwordConfirmation = Colors.green;
      }
      else {
        _passwordConfirmation = Colors.red;
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
            color: _eightChars,
          ),),
          Text('- Um ou mais caracteres especiais',textAlign: TextAlign.left,style: TextStyle(
            color: _specialCaracter,
          ),),
          Text('- Uma ou mais letras maiusculas',textAlign: TextAlign.left, style: TextStyle(
            color: _upperCase,
          ),),
          Text('- Uma ou mais letras minusculas',textAlign: TextAlign.left, style: TextStyle(
            color: _lowerCase,
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
          Text('A confirmacao precisa ser igual a senha',textAlign: TextAlign.start, style: TextStyle(
            color: _passwordConfirmation,
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