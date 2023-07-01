import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/auth/auth_provider.dart';
import 'package:frontend/screens/search/psychologists_list.dart';
import 'package:frontend/providers/database/firebase/firestore_general%20_dao.dart';

import '../../models/auth_model.dart';
import '../../models/especialist_model.dart';
import '../../utils/router.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nomePsicoloco = TextEditingController();
  String _selectedSpecialization = 'Especialização';
  var database = FirestoreDao<EspecialistModel>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final authModel = Provider.of<AuthModel>(context);
    final userType = authModel.userType;

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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.black,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(55),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (userType == UserType.Especialist) {
                              Navigator.of(context).restorablePushNamed(
                              Routes.edit_screen_psicologo,
                            );
                            } else {
                              Navigator.of(context).restorablePushNamed(
                              Routes.edit_screen_usuario,
                            );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: CircleBorder(),
                            padding: EdgeInsets.zero,
                          ),
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage('https://picsum.photos/200/300'),
                          ),
                        ),
                      )
                    ],
                  ),
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
                  CardList(items: database.dataListStream()),
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
