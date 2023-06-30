import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/models/especialist_model.dart';
import 'package:frontend/providers/database/firebase/firestore_general%20_dao.dart';
import 'package:frontend/providers/geo_services/coordinates_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:frontend/screens/auth/common.dart';
import 'package:search_cep/search_cep.dart';

import '../../../models/auth_model.dart';
import '../../../models/user_model.dart';
import '../../../providers/auth/auth_provider.dart';

class CadastroTerapeuta extends StatefulWidget {
  const CadastroTerapeuta({
    super.key,
  });

  @override
  State<CadastroTerapeuta> createState() => CadastroTerapeutaState();
}

class CadastroTerapeutaState extends State<CadastroTerapeuta> {
  final _formKey = GlobalKey<FormState>();

  File? _image;
  String? _selectedGender;
  final TextEditingController _nameTextContoller = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextContoller = TextEditingController();
  final TextEditingController _telefoneTextController = TextEditingController();
  final TextEditingController _cepTextController = TextEditingController();
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

  PostmonCepInfo? _postmonCepInfo;
  SearchCepError? _searchCepError;
  String? selectedState;
  String? selectedCity;
  bool _searchingCep = false;

  String _getPostmonCepInfoString() {
    return "${_postmonCepInfo!.logradouro}, ${_postmonCepInfo!.cidade} - ${_postmonCepInfo!.estado}, ${_postmonCepInfo!.cep}";
  }

  void _changeCepInfo() async {
    var cep = _cepTextController.text;

    if (_cepTextController.text.isEmpty) {
      setState(() {
        _searchCepError = null;
        _postmonCepInfo = null;
      });

      return;
    }

    var postmonSearchCep = PostmonSearchCep();

    setState(() {
      _searchingCep = true;
    });

    var postmonCepInfo = (await postmonSearchCep.searchInfoByCep(cep: cep));

    postmonCepInfo.fold((l) {
      setState(() {
        _searchCepError = l;
        _postmonCepInfo = null;
      });
    }, (r) {
      setState(() {
        _postmonCepInfo = r;
        _searchCepError = null;
      });
    });

    setState(() {
      _searchingCep = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final screenRouteArgs = ModalRoute.of(context)!.settings.arguments;
    final UserType? userType;

    if (screenRouteArgs == null) {
      final authModel = Provider.of<AuthModel>(context);
      final userModel = Provider.of<UserModel>(context);
      userType = authModel.userType;
    } else {
      userType = stringToUserType(screenRouteArgs as String);
    }

    return Scaffold(
        appBar: AppBar(),
        body: Center(
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
                        backgroundImage:
                            _image != null ? FileImage(_image!) : null,
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
                          return checkIsEmpty(campo);
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
                          }),
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
                        controller: _cepTextController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'CEP',
                        ),
                        onChanged: (String e) => _changeCepInfo(),
                        validator: (campo) {
                          if (_searchCepError != null) {
                            String out = _searchCepError!.errorMessage;
                            return null;
                          }
                          String? out = checkIsEmpty(campo);
                          if (out != null) {
                            return out;
                          }
                          return null;
                        },
                      ),
                      _searchCepError != null || _postmonCepInfo != null
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 6,
                                ),
                                !_searchingCep
                                    ? Container(
                                        width: double.infinity,
                                        padding: EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).hintColor,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Text(
                                          _searchCepError != null
                                              ? _searchCepError!.errorMessage
                                              : _getPostmonCepInfoString(),
                                          style: const TextStyle(
                                            fontSize: 16.0,
                                            color: Colors
                                                .white, // Apply validation error color
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      )
                                    : const CircularProgressIndicator(),
                              ],
                            )
                          : const SizedBox(),
                      userType == UserType.Especialist
                          ? TextFormField(
                              controller: _crptTextController,
                              decoration: const InputDecoration(
                                labelText: 'CRP',
                              ),
                              validator: (campo) {
                                return checkIsEmpty(campo);
                              },
                            )
                          : const SizedBox(),
                      userType == UserType.Especialist
                          ? DropdownButtonFormField(
                              value: _especialization,
                              items: especializationToStringList()
                                  .map((especialization) {
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
                                labelText: 'Gênero',
                              ),
                            )
                          : const SizedBox(),
                      userType == UserType.Especialist
                          ? TextFormField(
                              controller: _biosTextController,
                              decoration: const InputDecoration(
                                labelText: 'Bios',
                              ),
                              validator: (campo) {
                                return checkIsEmpty(campo);
                              },
                              minLines: 1,
                              maxLines: 10,
                            )
                          : const SizedBox(),
                      authProvider.status != Status.Authenticated
                          ? ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('Processing Data')),
                                  );

                                  AuthModel authModel = await authProvider
                                      .registerWithEmailPasswordAndUserType(
                                          _emailTextController.text,
                                          _passwordTextContoller.text,
                                          userType!);

                                  Map<String, double> coordinates =
                                      await CoordinatesService
                                              .fetchCoordinatesByAddrees(
                                                  _postmonCepInfo!.logradouro ??
                                                      "",
                                                  _postmonCepInfo!.cidade ?? "",
                                                  _postmonCepInfo!.estado ?? "",
                                                  _postmonCepInfo!.cep ?? "") ??
                                          {};

                                  if (userType == UserType.Patient) {
                                    final firestoreDao =
                                        FirestoreDao<UserModel>();

                                    await firestoreDao.setData(UserModel(
                                      id: authModel.uid,
                                      email: _emailTextController.text,
                                      fullName: _nameTextContoller.text,
                                      gender: stringToGender(_selectedGender!),
                                      phoneNumber: _telefoneTextController.text,
                                      latitude: coordinates["latitude"] ?? 0,
                                      longitude: coordinates["longitude"] ?? 0,
                                      address: _getPostmonCepInfoString(),
                                    ));
                                  } else {
                                    final firestoreDao =
                                        FirestoreDao<EspecialistModel>();

                                    await firestoreDao.setData(EspecialistModel(
                                      id: authModel.uid,
                                      email: _emailTextController.text,
                                      fullName: _nameTextContoller.text,
                                      gender: stringToGender(_selectedGender!),
                                      phoneNumber: _telefoneTextController.text,
                                      CRP: _crptTextController.text,
                                      especialization: stringToEspscialization(
                                          _especialization!),
                                      bios: _biosTextController.text,
                                      latitude: coordinates["latitude"] ?? 0,
                                      longitude: coordinates["longitude"] ?? 0,
                                      address: _getPostmonCepInfoString(),
                                    ));

                                    print(await firestoreDao
                                        .dataStream(todoId: authModel.uid)
                                        .first);
                                  }
                                }
                              },
                              child: const Text('Cadastrar'),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                authProvider.signOut();
                              },
                              child: const Text('sair'),
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
