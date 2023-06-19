import 'package:flutter/material.dart';

const int passwordSize = 6;

const String checkEmptyMessage = "O campo esta vazio";
const String checkEqualMessage = "Os valores são diferentes";
const String checkLengthMessage =
    "A senha não tem o número minimo de carcteres";
const String checkPasswordMessage = "su senha não segue o padrão";

String? checkIsEmpty(String? campo) {
  return (campo == null || campo.isEmpty) ? checkEmptyMessage : null;
}

String? checkIsEqual(String? campo, TextEditingController controller) {
  return campo != controller.text ? checkEqualMessage : null;
}

String? checkPasswordSize(String? campo) {
  return (campo != null && campo.length > passwordSize)
      ? null
      : checkLengthMessage;
}

String? testUpperCase(text) {
  RegExp upperCase = RegExp(r'.*[A-Z].*');
  if (upperCase.hasMatch(text)) {
    return null;
  } else {
    return checkPasswordMessage;
  }
}

String? testLowerCase(text) {
  RegExp lowerCase = RegExp(r'.*[a-z].*');
  if (lowerCase.hasMatch(text)) {
    return null;
  } else {
    return checkPasswordMessage;
  }
}

String? testSpecialCaracters(text) {
  RegExp especialCaracters = RegExp(r'.*[!@#\$&*~].*');
  if (especialCaracters.hasMatch(text)) {
    return null;
  } else {
    return checkPasswordMessage;
  }
}
