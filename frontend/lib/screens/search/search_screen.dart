import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth/auth_provider.dart';
import 'package:frontend/screens/search/psychologists_list.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomePsicoloco = TextEditingController();
  String _selectedSpecialization = 'Especialização';
  final List<List<String>> items = [
    [
      'https://example.com/image1.jpg',
      'Texto 1',
      'Texto 2',
      'Texto 3',
    ],
    [
      'https://example.com/image2.jpg',
      'text1',
      'text2',
      'text3',
    ],
    // Adicione mais itens conforme necessário
  ];

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
                  TextFormField(
                    controller: _nomePsicoloco,
                    decoration: const InputDecoration(
                      labelText: "Nome do psicólogo",
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedSpecialization,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.indigo),
                    underline: Container(
                      height: 2,
                      color: Colors.indigoAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSpecialization = newValue ?? '';
                      });
                    },
                    items: <String>['Especialização', '1', '2', '3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 18),
                  authProvider.status == Status.Authenticating
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ElevatedButton(
                          child: const Text('Pesquisar'),
                          onPressed: () async {
                            // if (_formKey.currentState!.validate()) {
                            //   FocusScope.of(context)
                            //       .unfocus(); //to hide the keyboard - if any
                            //
                            //   bool status =
                            //   await authProvider.signInWithEmailAndPassword(
                            //       _emailTextController.text,
                            //       _passwordTextContoller.text);
                            //
                            //   if (!status) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       const SnackBar(
                            //         content: Text('Acesso Negado'),
                            //       ),
                            //     );
                            //   } else {
                            //     Navigator.of(context).pushReplacementNamed(
                            //         Routes.cadastro_especialist_screen);
                            //   }
                            // }
                          }),
                  const SizedBox(height: 18),
                  CardList(items: items),
                  ElevatedButton(
                    onPressed: () {
                      authProvider.signOut();
                    },
                    child: const Text("Sair"),
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
