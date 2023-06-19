import 'package:test/test.dart';
import 'package:frontend/cadastro_paciente.dart';

void main() {

  group("Pagina de cadastro de pacientes",(){
  test('Password has less than 8 caracters', () {
    final CadastroPacienteState estado = CadastroPacienteState();
    expect(estado.testPasswordLength("Aaaaaaa"), -1);
    expect(estado.testPasswordLength(""), 0);
    expect(estado.testPasswordLength("Aaaaaaaaaaa"),1);
  });

  test("Password has at least one upper case letter",(){
    final CadastroPacienteState estado = CadastroPacienteState();
    expect(estado.testUpperCase("aaaaaaaa"), -1);
    expect(estado.testUpperCase(""),0);
    expect(estado.testUpperCase("aaaaAaaa"), 1);
  });

  test("Password has at least one lower case letter",(){
    final CadastroPacienteState estado = CadastroPacienteState();
    expect(estado.testLowerCase("AAAAAAAAA"), -1);
    expect(estado.testLowerCase(""),0);
    expect(estado.testLowerCase("AAaAAAAA"), 1);
  });

  test("Password has at least one special caracter",(){
    final CadastroPacienteState estado = CadastroPacienteState();
    expect(estado.testSpecialCaracters("aaaaaaaa"), -1);
    expect(estado.testSpecialCaracters(""),0);
    expect(estado.testSpecialCaracters("aa\$aaaaaaa"), 1);
  });

  });
}