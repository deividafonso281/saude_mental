import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/models/especialist_model.dart';
import 'package:frontend/providers/database/firebase/firestore_general%20_dao.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:frontend/screens/auth/common.dart';

import '../../../models/auth_model.dart';
import '../../../models/user_model.dart';
import '../../../providers/auth/auth_provider.dart';
import '../../../utils/router.dart';

class EditScreenPsicologo extends StatefulWidget {
  const EditScreenPsicologo({
    Key? key,
  }) : super(key: key);

  @override
  State<EditScreenPsicologo> createState() => EditScreenPsicologoState();
}

class EditScreenPsicologoState extends State<EditScreenPsicologo> {
  final _formKey = GlobalKey<FormState>();
  String imageUrl = "";
  File? _image;
  String? _selectedGender;
  final TextEditingController _nameTextContoller = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextContoller = TextEditingController();
  final TextEditingController _telefoneTextController = TextEditingController();
  final TextEditingController _birthDateTextController =
      TextEditingController();

  // Dados do especialista
  String? _especialization;
  final TextEditingController _biosTextController = TextEditingController();
  final TextEditingController _crptTextController = TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final screenRouteArgs = ModalRoute.of(context)!.settings.arguments;
    final authModel = Provider.of<AuthModel>(context);

    final FirestoreDao<EspecialistModel> firestoreDao = FirestoreDao<EspecialistModel>();

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: firestoreDao.getById(modelId: authModel.uid),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return const Text("Erro");
          }

          EspecialistModel data = snapshot.data!;

          ImageProvider? imageSource = null;
          if(data.imageUrl != ""){
            imageSource = NetworkImage(data.imageUrl);
          }
          if(_image != null){
            imageSource = FileImage(_image!);
          }

          return Center(
            child: Form(
              key: _formKey,
              child: Scrollbar(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage:  imageSource,
                          child: _image == null
                              ? const Icon(
                                  Icons.person,
                                  size: 80,
                                )
                              : null,
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _pickImage(ImageSource.camera);
                              },
                              child: const Text('Take a picture'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _pickImage(ImageSource.gallery);
                              },
                              child: const Text('Pick an image'),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: _nameTextContoller,
                          decoration: const InputDecoration(
                            labelText: 'Nome completo *',
                          ),
                          validator: (campo) {
                            return checkIsEmpty(campo);
                          },
                          keyboardType: TextInputType.text,
                        ),
                        TextFormField(
                          controller: _birthDateTextController,
                          decoration: const InputDecoration(
                            labelText: 'Data de nascimento *',
                          ),
                          keyboardType: TextInputType.datetime,
                          validator: (campo) {
                            return checkIsEmpty
                            (campo);
                          },
                        ),
                        DropdownButtonFormField(
                          value: _selectedGender,
                          items: genderToStringList().map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          validator: (campo) {
                            return checkIsEmpty(campo);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Gênero',
                          ),
                        ),
                        TextFormField(
                          controller: _telefoneTextController,
                          decoration: const InputDecoration(
                            labelText: 'Telefone *',
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (campo) {
                            return checkIsEmpty(campo);
                          },
                        ),
                        TextFormField(
                          controller: _emailTextController,
                          decoration: const InputDecoration(
                            labelText: 'Email *',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (campo) {
                            return checkIsEmpty(campo);
                          },
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Confirmar email *',
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (campo) {
                            String? out = checkIsEmpty(campo);
                            if (out != null) return out;
                            return checkIsEqual(campo, _emailTextController);
                          },
                        ),
                        TextFormField(
                          controller: _passwordTextContoller,
                          decoration: const InputDecoration(
                            labelText: 'Senha *',
                          ),
                          validator: (campo) {
                            return checkIsEmpty(campo);
                          },
                          obscureText: true,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Confirmar senha *',
                          ),
                          validator: (campo) {
                            String? out = checkIsEmpty(campo);
                            if (out != null) return out;
                            return checkIsEqual(campo, _passwordTextContoller);
                          },
                          obscureText: true,
                        ),
                        TextFormField(
                                controller: _crptTextController,
                                decoration: const InputDecoration(
                                  labelText: 'CRP',
                                ),
                                validator: (campo) {
                                  return checkIsEmpty(campo);
                                },
                              ),
                        DropdownButtonFormField(
                                value: _especialization,
                                items: especializationToStringList().map((especialization) {
                                  return DropdownMenuItem(
                                    value: especialization,
                                    child: Text(especialization),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    _especialization = value;
                                  });
                                },
                                validator: (campo) {
                                  return checkIsEmpty(campo);
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Especialização',
                                ),
                              ),
                        TextFormField(
                                controller: _biosTextController,
                                decoration: const InputDecoration(
                                  labelText: 'Bios',
                                ),
                                validator: (campo) {
                                  return checkIsEmpty(campo);
                                },
                              ),
                        ElevatedButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Processing Data'),
                                      ),
                                    );

                                        final firestoreDao = FirestoreDao<EspecialistModel>();

                                        await firestoreDao.setData(
                                          EspecialistModel(
                                            id: authModel.uid,
                                            email: _emailTextController.text,
                                            fullName: _nameTextContoller.text,
                                            gender: stringToGender(_selectedGender!),
                                            phoneNumber: _telefoneTextController.text,
                                            CRP: _crptTextController.text,
                                            especialization: stringToEspscialization(_especialization!),
                                            bios: _biosTextController.text,
                                            imageUrl: imageUrl,
                                          ),
                                        );
                                        Navigator.of(context).restorablePushNamed(
                                          Routes.busca_psicologo_screen,
                                          );
                                      }
                                      
                                    },
                                    
                                  child: const Text('Salvar'),
                                )
                              
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

