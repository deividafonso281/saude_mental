import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:frontend/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class CadastroTerapeuta extends StatefulWidget {
  const CadastroTerapeuta({
    super.key,
  });

  @override
  State<CadastroTerapeuta> createState() => CadastroTerapeutaState();
}

class CadastroTerapeutaState extends State<CadastroTerapeuta> {
  final _formKey = GlobalKey<FormState>();

  final checkEmptyMessage = "O campo esta vazio";
  final checkEqualMessage = "Os valores são diferentes";

  File? _image;

  String? _selectedGender;
  final List<String> _genders = ['Feminino', 'Não-Binário', 'Masculino'];

  final TextEditingController _nameTextContoller = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextContoller = TextEditingController();
  final TextEditingController _telefoneTextController = TextEditingController();
  final TextEditingController _birthDateTextController =
      TextEditingController();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  String? checkIsEmpty(String? campo) {
    return (campo == null || campo.isEmpty) ? checkEmptyMessage : null;
  }

  String? checkIsEqual(String? campo, TextEditingController controller) {
    return campo != controller.text ? checkEqualMessage : null;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

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
                        items: _genders.map((gender) {
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
                      ElevatedButton(
                        onPressed: () {
                          authProvider.signOut();
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        child: const Text('Cadastrar'),
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
