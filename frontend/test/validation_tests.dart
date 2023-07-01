import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/common.dart';
import 'package:frontend/screens/auth/register/register_screen.dart';
import 'package:test/test.dart';
import 'package:intl/intl.dart';

void main() {

// Scenario #	     Test Scenario Description	                   Expected Outcome
//    1	       Enter 0 to 6 characters in password field	    System should not accept
//    2	       Enter 7 to 12 characters in password field	    System should accept
//    3	       Enter 13 or more character in password field	  System should not accept

  group('ValidaSenha', (){
    test('should return error when password has less than seven characters', () {

      expect(checkPasswordSizeNotMinimum('12345'), checkMinimumLengthMessage);
      expect(checkPasswordSizeNotMinimum('123456'), checkMinimumLengthMessage);
      expect(checkPasswordSizeNotMinimum('1234567'), null);

    });

    test('should not return error when password has more than six and less than twelve characters', () {

      expect(checkPasswordSizeNotMinimum('1234567'), null);
      expect(checkPasswordSizeNotMinimum('12345678'), null);
      expect(checkPasswordSizeNotMinimum('123456789'), null);
      expect(checkPasswordSizeNotMinimum('1234567890'), null);
      expect(checkPasswordSizeNotMinimum('12345678901'), null);
      expect(checkPasswordSizeNotMinimum('123456789012'), null);

    });

    test('should return error when password has more than eleven characters', () {
      
      expect(checkPasswordSizeNotmaximum('123456789101'), null);
      expect(checkPasswordSizeNotmaximum('1234567891012'), checkMaximumLengthMessage);
      expect(checkPasswordSizeNotmaximum('12345678910123'), checkMaximumLengthMessage);

    });
  });

  // Scenario #	     Test Scenario Description	                     Expected Outcome
  //    1	       Enter 0 to 9 characters in Bios field	          System should not accept
  //    2	       Enter 10 to 200 characters in password field	    System should accept
  //    3	       Enter 201 or more character in password field	  System should not accept

  group('ValidaBIOS', (){

    test('should return error when Bios has less than 10 characters', () {

      expect(checkBiosSizeNotMinimum('Respeito'), checkBiosMinimo);
      expect(checkBiosSizeNotMinimum('Bem vindo'), checkBiosMinimo);
      expect(checkBiosSizeNotMaximum('Olá amigos'), null);

    });

    test('should not return error when Bios has more than 9 and less than 201 characters', () {

      expect(checkBiosSizeNotMinimum('Olá! Eu sou um psicólogo residente em São Paulo.'), null);
      expect(checkBiosSizeNotMinimum('Olá! Eu sou um psicólogo residente em São Paulo, busco te ajudar a ser o seu melhor eu e superar desafios. '), null);
      expect(checkBiosSizeNotMaximum('Olá! Eu sou um psicólogo residente em São Paulo, busco te ajudar a ser o seu melhor eu e superar desafios. Qualquer dúvida pode me chamar, espero poder trabalhar contigo'), null);

    });

    test('should return error when Bios has more than 200 characters', () {

      String duzentosCaracteres = 'Olá! Eu sou um psicólogo residente em São Paulo, busco te ajudar a ser o seu melhor eu e superar desafios. Qualquer dúvida pode me chamar, espero poder trabalhar contigo e te acompanhar na sua jornada';
      String duzentosUmCaracteres = 'Olá! Eu sou um psicólogo residente em São Paulo, busco te ajudar a ser o seu melhor eu e superar desafios. Qualquer dúvida pode me chamar, espero poder trabalhar contigo e te acompanhar na sua jornada.';
      String duzentosDoisCaracteres = 'Olá! Eu sou um psicólogo residente em São Paulo, busco te ajudar a ser o seu melhor eu e superar desafios. Qualquer dúvida pode me chamar, espero poder trabalhar contigo e te acompanhar na sua jornada!!';
      
      expect(checkBiosSizeNotMaximum(duzentosCaracteres), null);
      expect(checkBiosSizeNotMaximum(duzentosUmCaracteres), checkBiosMaximo);
      expect(checkBiosSizeNotMaximum(duzentosDoisCaracteres), checkBiosMaximo);
    });
  });

  // Scenario #	     Test Scenario Description	               Expected Outcome
  //    1	       Enter 0 to 2 characters in CRP field	     System should not accept
  //    2	       Enter 3 to 8 characters in CRP field	     System should accept
  //    3	       Enter 9 or more character in CRP field	   System should not accept

  group('ValidaCRP', (){

    test('should return error when CRP has less than three characters', () {

      expect(checkCRPSizeNotMinimum('1'), checkCRPMinimo);
      expect(checkCRPSizeNotMinimum('01'), checkCRPMinimo);
      expect(checkCRPSizeNotMinimum('001'), null);
    });

    test('should not return error when CRP has more than two and less than nine characters', () {

      expect(checkCRPSizeNotMinimum('123'), null);
      expect(checkCRPSizeNotMinimum('1234'), null);
      expect(checkCRPSizeNotMinimum('12345'), null);
      expect(checkCRPSizeNotMinimum('123456'), null);
      expect(checkCRPSizeNotMinimum('1234567'), null);
      expect(checkCRPSizeNotMinimum('12345678'), null);
    });

    test('should return error when CRP has more than eight characters', () {

      expect(checkCRPSizeNotmaximum('06123457'), null);
      expect(checkCRPSizeNotmaximum('061234567'), checkCRPMaximo);
      expect(checkCRPSizeNotmaximum('0612345678'), checkCRPMaximo);
    });

  });

  // Scenario #	     Test Scenario Description	               Expected Outcome
  //    1	       Input date is before 1900	               System should not accept
  //    2	       Input date is between 1900 and today	     System should accept
  //    3	       Input date in after today	               System should not accept

  group('ValidaDataNascimento', (){

    test('should return error when birth date is before 1900', () {

      expect(validateBirthDate('30/12/1899'), checkDateYear);
      expect(validateBirthDate('31/12/1899'), checkDateYear);
      expect(validateBirthDate('01/01/1900'), null);
    });

    test('should return error when birth date is anfter 1900 and before today', () {

      expect(validateBirthDate('31/12/1899'), checkDateYear);
      expect(validateBirthDate('01/01/1900'), null);
    });

    test('should return error when birth date is after today', () {
      DateTime now = DateTime.now();
      DateTime tomorrow = DateTime.now().add(Duration(days: 1));
      DateTime afterTomorrow = DateTime.now().add(Duration(days: 2));
      expect(validateBirthDate(DateFormat('dd/MM/yyyy').format(now)), null);
      expect(validateBirthDate(DateFormat('dd/MM/yyyy').format(tomorrow)), checkDateYear);
      expect(validateBirthDate(DateFormat('dd/MM/yyyy').format(afterTomorrow)), checkDateYear);
    });

  });
}