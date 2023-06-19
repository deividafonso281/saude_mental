import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/models/auth_model.dart';

import '../../../utils/router.dart';

class IntermedieteRegisterScreen extends StatelessWidget {
  const IntermedieteRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).restorablePushNamed(
                        Routes.cadastro_especialist_screen,
                        arguments: UserType.Especialist.toShortString());
                  },
                  child: Text("Especialista"),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).restorablePushNamed(
                        Routes.cadastro_especialist_screen,
                        arguments: UserType.Patient.toShortString());
                  },
                  child: Text("Paciente"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
