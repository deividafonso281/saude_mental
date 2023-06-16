import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required String title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.diversity_1_outlined,
                  size: 160,
                  color: Colors.blue,
                ),
                const SizedBox(height: 18),
                TextFormField(
                  controller: _emailTextController,
                  decoration: const InputDecoration(
                    labelText: "E-mail",
                  ),
                ),
                TextFormField(
                  controller: _passwordTextContoller,
                  decoration: const InputDecoration(
                    labelText: "Senha",
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Logar'),
                ),
                const SizedBox(height: 18),
                const Text("Se não esta cadastrado, cadastre-se"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
