import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/register/cadastro_especialista_screen.dart';
import 'package:test/test.dart';

void main() {
  group('Counter', () {
    test('The string must have a value', () {
      final CadastroTerapeutaState cadastroTerapeutaState =
          CadastroTerapeutaState();
      expect(cadastroTerapeutaState.checkIsEmpty(null),
          cadastroTerapeutaState.checkEmptyMessage);
      expect(cadastroTerapeutaState.checkIsEmpty(''),
          cadastroTerapeutaState.checkEmptyMessage);
      expect(cadastroTerapeutaState.checkIsEmpty('mock'), null);
    });

    test('The fields values must be the same', () {
      final CadastroTerapeutaState cadastroTerapeutaState =
          CadastroTerapeutaState();
      final TextEditingController textEditingController =
          TextEditingController();
      const String stringMock = "Mock values";

      // Is equal
      textEditingController.text = stringMock;
      expect(
          cadastroTerapeutaState.checkIsEqual(
              stringMock, textEditingController),
          null);

      // Is different
      textEditingController.text = "different";
      expect(
          cadastroTerapeutaState.checkIsEqual(
              stringMock, textEditingController),
          cadastroTerapeutaState.checkEqualMessage);
    });
  });
}
