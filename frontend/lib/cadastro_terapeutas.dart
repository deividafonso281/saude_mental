import 'package:flutter/material.dart';

class CadastroTerapeuta extends StatefulWidget {
  const CadastroTerapeuta({super.key, required this.title});

  final String title;

  @override
  State<CadastroTerapeuta> createState() => _CadastroTerapeutaState();
}

class _CadastroTerapeutaState extends State<CadastroTerapeuta> {
  int _counter = 0;
  final _formKey = GlobalKey<FormState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Form(
        key: _formKey,
        child: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirmar email',
                  ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                  ),
                  obscureText: true,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Confirmar senha',
                  ),
                  obscureText: true,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                      textStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () {}, 
                    child: const Text('Cadastrar'),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
