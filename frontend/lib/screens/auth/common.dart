import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const int minimumPasswordSize = 7;
const int maximumPasswordSize = 12;

const int minimumCRPSize = 3;
const int maximumCRPSize = 8;

const int minimumBiosSize = 10;
const int maximumBiosSize = 200;

const String checkEmptyMessage = "O campo esta vazio";
const String checkEqualMessage = "Os valores são diferentes";
const String checkMinimumLengthMessage = "A senha deve ter no mínimo sete caracteres";
const String checkMaximumLengthMessage = "A senha deve ter no máximo onze caracteres";
const String checkPasswordMessage = "A senha deve seguir o padrão";

const String checkCRPMaximo = "O seu CRP precisa ter no máximo oito dígitos";
const String checkCRPMinimo = "O seu CRP precisa conter seu regional e número da inscrição";
const String checkCRPNumero = "O CRP só pode conter números";

const String checkBiosMaximo = "A bio pode ter no máximo 200 caracteres";
const String checkBiosMinimo = "A bio precisa ter no máximo 10 caracteres";
const String checkDateYear = 'Insira uma data entre 1900 e hoje';

String? checkIsEmpty(String? campo) {
  return (campo == null || campo.isEmpty) ? checkEmptyMessage : null;
}

String? checkIsEqual(String? campo, TextEditingController controller) {
  return campo != controller.text ? checkEqualMessage : null;
}

String? checkPasswordSizeNotMinimum(String? campo) {
  return (campo != null && campo.length < minimumPasswordSize)
      ? checkMinimumLengthMessage
      : null;
}

String? checkPasswordSizeNotmaximum(String? campo) {
  return (campo != null && campo.length > maximumPasswordSize)
      ? checkMaximumLengthMessage
      : null;
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

String? checkCRPSizeNotMinimum(String? campo) {
  return (campo != null && campo.length < minimumCRPSize)
      ? checkCRPMinimo
      : null;
}

String? checkCRPSizeNotmaximum(String? campo) {
  return (campo != null && campo.length > maximumCRPSize)
      ? checkCRPMaximo
      : null;
}

String? testUpperCaseCRP(text) {
  RegExp upperCase = RegExp(r'.*[A-Z].*');
  if (upperCase.hasMatch(text)) {
    return checkCRPNumero;
  } else {
    return null;
  }
}

String? testLowerCaseCRP(text) {
  RegExp lowerCase = RegExp(r'.*[a-z].*');
  if (lowerCase.hasMatch(text)) {
    return checkCRPNumero;
  } else {
    return null;
  }
}

String? testSpecialCaractersCRP(text) {
  RegExp especialCaracters = RegExp(r'.*[!@#\$&*~].*');
  if (especialCaracters.hasMatch(text)) {
    return checkCRPNumero;
  } else {
    return null;
  }
}

String? checkBiosSizeNotMinimum(String? campo) {
  return (campo != null && campo.length < minimumBiosSize)
      ? checkBiosMinimo
      : null;
}

String? checkBiosSizeNotMaximum(String? campo) {
  return (campo != null && campo.length > maximumBiosSize)
      ? checkBiosMaximo
      : null;
}

String? validateBirthDate(String? campo) {

  var isEmpty = checkIsEmpty(campo);

  if (isEmpty == null) {
    // Converter a string da data em um objeto DateTime
    final inputDate = DateFormat('dd/MM/yyyy').parse(campo ?? '');

    // Definir as datas mínima e máxima permitidas
    final minDate = DateTime(1900);
    final maxDate = DateTime.now();

    // Verificar se a data está fora do intervalo permitido
    if (inputDate.isBefore(minDate) || inputDate.isAfter(maxDate)) {
      return checkDateYear;
    }

    // Retornar null se a data for válida
    return null;
  } else {
    return isEmpty;
  }

}
