import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/screens/search/common.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth/auth_provider.dart';
import 'package:frontend/screens/search/psychologists_list.dart';
import 'package:frontend/providers/database/firebase/firestore_general%20_dao.dart';

import '../../models/especialist_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomePsicoloco = TextEditingController();
  String _selectedSpecialization = 'Especialização';
  String? _selectedKmText;
  double? _selectedKm;
  var database = FirestoreDao<EspecialistModel>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userModel = Provider.of<AuthModel>(context, listen: false).userData;

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
                  DropdownButton<String>(
                    isExpanded: true,
                    value: _selectedKmText,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.indigo),
                    underline: Container(
                      height: 2,
                      color: Colors.indigoAccent,
                    ),
                    onChanged: (newValue) {
                      if (newValue == "Padrão") newValue = null;

                      setState(() {
                        _selectedKm = newValue != null
                            ? double.parse(newValue)
                            : double.infinity;
                        _selectedKmText = newValue;
                      });
                    },
                    items: ["Padrão", "20", "50", "60"]
                        .map<DropdownMenuItem<String>>((var value) {
                      if (value == "Padrão") {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text("$value"),
                        );
                      }

                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text("$value km"),
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
                  CardList(
                      items: database.dataListStream().map((listEsp) {
                    List<EspecialistModel> out = [];
                    for (EspecialistModel esp in listEsp) {
                      if (calculateDistance(esp.latitude, esp.longitude,
                              userModel!.latitude, userModel.longitude) <
                          (_selectedKm ?? double.infinity)) {
                        out.add(esp);
                      }
                    }

                    return out;
                  })),
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
