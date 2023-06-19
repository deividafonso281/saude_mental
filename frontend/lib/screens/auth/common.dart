import 'package:flutter/material.dart';

const int passwordSize = 6;

const String checkEmptyMessage = "O campo esta vazio";
const String checkEqualMessage = "Os valores são diferentes";
const String checkLengthMessage =
    "A senha não tem o número minimo de carcteres";

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
