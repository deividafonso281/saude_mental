import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CadastroTerapeuta extends StatefulWidget {
  const CadastroTerapeuta({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<CadastroTerapeuta> createState() => CadastroTerapeutaState();
}

class CadastroTerapeutaState extends State<CadastroTerapeuta> {
  String _password = '';
  Color _eightChars = Colors.black;
  Color _specialCaracter = Colors.black;
  Color _upperCase = Colors.black;
  Color _lowerCase = Colors.black;
  Color _passwordConfirmation = Colors.black;
  Color _emailConfirmation = Colors.black;
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _emailConfirmationTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _passwordConfirmationTextContoller = TextEditingController();
  final List<String> _genders = ['Feminino', 'Não-Binário', 'Masculino'];
  String? _selectedGender;
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

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
      if (text==_passwordTextController) {
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

  void _validateEmailConfirmation(text) {
    setState(() {
      if (text=="") {
        _emailConfirmation = Colors.black;
      }
      else if (text == _emailTextController.text) {
        _emailConfirmation = Colors.blue;
      }
      else {
        _emailConfirmation = Colors.red;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Safe Mind"),
      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 80,
              backgroundImage: _image != null ? FileImage(_image!) : null,
              child: _image == null
                ? Icon(
                  Icons.person,
                  size: 80,
                )
                : null,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _pickImage(ImageSource.camera);
                  },
                  child: Text('Take a picture'),
                ),
                ElevatedButton(
                  onPressed: () {
                    _pickImage(ImageSource.gallery);
                  },
                  child: Text('Pick an image'),
                ),
              ],
            ),
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Nome Completo',
              ),
            ),
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Data de Nascimento',
              ),
            ),
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Telefone',
              ),
            ),
            DropdownButtonFormField(
              value: _selectedGender, // Set the selected option
              items: _genders.map((gender) { // Map the list of options to DropdownMenuItem widgets
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (value) { // Set the selected option to the variable when the user changes it
                setState(() {
                  _selectedGender = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Gênero',
              ),
            ),
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'CEP',
              ),
            ),
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Endereco',
              ),
            ),
            const TextField(
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Numero',
              ),
            ),
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
            TextField(
              obscureText: false,
              controller: _emailTextController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              obscureText: false,
              onChanged: (text) {
                _validateEmailConfirmation(text);
              },
              decoration: InputDecoration(
                labelText: 'Confirmar email',
                suffixIcon: const Tooltip(message:"Os e-mails precisam ser iguais", child: Icon(Icons.info)),
                iconColor: _emailConfirmation,
                labelStyle: TextStyle(color: _emailConfirmation),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: _emailConfirmation) ,borderRadius: BorderRadius.circular(25.0)),
              ),
            ),
            TextField(
              controller: _passwordTextController,
              onChanged: (text) {
                _validatePassword(text);
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Senha',
                suffixIcon: Tooltip(message: "Sua senha precisa:\n- Oito ou mais caracteres\n- Um ou mais caracteres especiais\n- Uma ou mais letras maiusculas\n- Uma ou mais letras minusculas", child: Icon(Icons.info)),
              ),
            ),
            TextField(
              onChanged: (text) {
                _validatePasswordConfirmation(text);
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar senha',
                suffixIcon: Tooltip(message: "As senhas precisam ser iguais", child: Icon(Icons.info)),
              ),
            ),
            ElevatedButton(
                onPressed: (){},
                child: const Text("Cadastrar")
            )
          ],
        ),
      ),
    );
  }
}