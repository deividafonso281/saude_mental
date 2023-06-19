import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/common.dart';
import 'package:frontend/screens/auth/register/register_screen.dart';
import 'package:test/test.dart';

void main() {
  group('Counter', () {
    test('The string must have a value', () {
      expect(checkIsEmpty(null), checkEmptyMessage);
      expect(checkIsEmpty(''), checkEmptyMessage);
      expect(checkIsEmpty('mock'), null);
    });

    test('The fields values must be the same', () {
      final TextEditingController textEditingController =
          TextEditingController();
      const String stringMock = "Mock values";

      // Is equal
      textEditingController.text = stringMock;
      expect(checkIsEqual(stringMock, textEditingController), null);

      // Is different
      textEditingController.text = "different";
      expect(
          checkIsEqual(stringMock, textEditingController), checkEqualMessage);
    });

    test('The minimum password size text', () {
      expect(checkPasswordSize("123456"), checkLengthMessage);
      expect(checkPasswordSize("12345"), checkLengthMessage);
      expect(checkPasswordSize(null), checkLengthMessage);
      expect(checkPasswordSize("1234567"), null);
    });
  });
}
