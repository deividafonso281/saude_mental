import 'package:flutter/material.dart';

class CadastroTerapeuta extends StatefulWidget {
  const CadastroTerapeuta({super.key, required this.title});

  final String title;

  @override
  State<CadastroTerapeuta> createState() => _CadastroTerapeutaState();
}

class _CadastroTerapeutaState extends State<CadastroTerapeuta> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
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

                    // const Icon(
                    //   Icons.audiotrack,
                    //   color: Colors.green,
                    //   size: 30.0,
                    // ),

                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        labelText: 'Nome completo *',
                      ),
                      validator: (nome) {
                        if (nome == null || nome.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_month),
                        labelText: 'Data de nascimento *',
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (dataNascimento) {
                        if (dataNascimento == null || dataNascimento.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.phone),
                        labelText: 'Telefone *',
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (telefone) {
                        if (telefone == null || telefone.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    // Esse próximo é pra ser uma caixa de seleção
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.female),
                        labelText: 'Gênero *',
                      ),
                      validator: (genero) {
                        if (genero == null || genero.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    // Esse próximo é pra ser uma caixa de seleção
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.health_and_safety),
                        labelText: 'Especialidade *',
                      ),
                      validator: (especialidade) {
                        if (especialidade == null || especialidade.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.perm_identity),
                        labelText: 'CRM *',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (numeroEspecialista) {
                        if (numeroEspecialista == null || numeroEspecialista.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    // Fazer autocompletar com o CEP
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.numbers),
                        labelText: 'CEP *',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (cep) {
                        if (cep == null || cep.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.streetview),
                        labelText: 'Endereço *',
                      ),
                      enabled: false,
                      validator: (endereco) {
                        if (endereco == null || endereco.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.numbers),
                        labelText: 'Número *',
                      ),
                      keyboardType: TextInputType.number,
                      validator: (numCasa) {
                        if (numCasa == null || numCasa.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.house),
                        labelText: 'Bairro *',
                      ),
                      enabled: false,
                      validator: (bairro) {
                        if (bairro == null || bairro.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.location_city),
                        labelText: 'Cidade *',
                      ),
                      enabled: false,
                      validator: (cidade) {
                        if (cidade == null || cidade.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.location_city),
                        labelText: 'País *',
                      ),
                      enabled: false,
                      validator: (pais) {
                        if (pais == null || pais.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.numbers),
                        labelText: 'Complemento',
                      ),
                      keyboardType: TextInputType.text,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.abc),
                        labelText: 'Formação Acadêmica *',
                      ),
                      validator: (formacaoAcademica) {
                        if (formacaoAcademica == null || formacaoAcademica.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.label),
                        labelText: 'Experiência profissional *',
                      ),
                      validator: (experienciaProfissional) {
                        if (experienciaProfissional == null || experienciaProfissional.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.date_range),
                        labelText: 'Horários de atendimento *',
                      ),
                      validator: (horariosAtendimento) {
                        if (horariosAtendimento == null || horariosAtendimento.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.money),
                        labelText: 'Valores cobrados *',
                      ),
                      validator: (valoresCobrados) {
                        if (valoresCobrados == null || valoresCobrados.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    // Esse próximo vai ser uma caixa de seleção ou checkbox
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.network_cell),
                        labelText: 'Tem disponibilidade para atender em qual modelo (presencial, online, os dois) *',
                      ),
                      validator: (disponibilidadeAtendimento) {
                        if (disponibilidadeAtendimento == null || disponibilidadeAtendimento.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    // Esse próximo vai ser um checkbox com (quase) todos os convênios
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.local_hospital),
                        labelText: 'Vínculos com convênios *',
                      ),
                      validator: (vinculosConvenio) {
                        if (vinculosConvenio == null || vinculosConvenio.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Email *',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (email) {
                        if (email == null || email.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        labelText: 'Confirmar email *',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (confirmarEmail) {
                        if (confirmarEmail == null || confirmarEmail.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.password),
                        labelText: 'Senha *',
                    ),
                    validator: (senha) {
                        if (senha == null || senha.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    obscureText: true,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        icon: Icon(Icons.password),
                        labelText: 'Confirmar senha *',
                    ),
                    validator: (confirmarSenha) {
                        if (confirmarSenha == null || confirmarSenha.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    obscureText: true,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      child: const Text('Cadastrar'),
                    ),
                    // TextButton(
                    //   style: TextButton.styleFrom(
                    //     backgroundColor: Colors.blue,
                    //     textStyle: TextStyle(
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    //   onPressed: () {}, 
                    //   child: const Text('Cadastrar'),
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    );
  }
}
