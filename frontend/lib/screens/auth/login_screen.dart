import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/common.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';
import '../../utils/router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
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
                    validator: (campo) => checkPasswordSize(campo),
                    obscureText: true,
                  ),
                  const SizedBox(height: 18),
                  authProvider.status == Status.Authenticating
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          child: const Text('Logar'),
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context)
                                  .unfocus(); //to hide the keyboard - if any

                              bool status =
                                  await authProvider.signInWithEmailAndPassword(
                                      _emailTextController.text,
                                      _passwordTextContoller.text);

                              if (!status) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Acesso Negado'),
                                  ),
                                );
                              } else {
                                Navigator.of(context).pushReplacementNamed(
                                    Routes.cadastro_especialist_screen);
                              }
                            }
                          }),
                  const SizedBox(height: 18),
                  const Text("Se não esta cadastrado"),
                  TextButton(
                    child: const Text("Registre-se"),
                    onPressed: () {
                      Navigator.of(context).restorablePushNamed(
                          Routes.intermediete_register_screen);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
