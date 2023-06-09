import 'package:frontend/models/base_model.dart';
import 'package:frontend/models/convertos/map_converter_interface.dart';

class UserModelConverter implements MapConverter<UserModel> {
  @override
  UserModel fromMap(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      email: json["email"],
      fullName: json["fullName"],
      gender: json["gender"],
      phoneNumber: json["phoneNumber"],
    );
  }

  @override
  Map<String, dynamic> toMap(UserModel model) {
    return {
      "id": model.id,
      "email": model.email,
      "fullName": model.fullName,
      "gender": model.gender,
      "phoneNumber": model.phoneNumber,
    };
  }
}

class UserModel extends BaseModel {
  String id;
  String email;
  String fullName;
  Gender gender;
  String phoneNumber;

  UserModel(
      {required this.id,
      required this.email,
      required this.fullName,
      required this.gender,
      required this.phoneNumber})
      : super(id: id);
}

enum Gender {
  Female,
  NonBinary,
  Male,
}

extension ParseToString on Gender {
  String toShortString() {
    switch (this) {
      case Gender.Female:
        return "Feminino";
      case Gender.NonBinary:
        return "Não binario";
      case Gender.Male:
        return "Masculino";
      default:
        return "";
    }
  }
}

List<String> genderToStringList() {
  return Gender.values.map((esp) => esp.toShortString()).toList();
}

Gender stringToGender(String gender) {
  switch (gender) {
    case "Feminino":
      return Gender.Female;
    case "Masculino":
      return Gender.Male;
    case "Não binario":
      return Gender.NonBinary;
    default:
      return Gender.NonBinary;
  }
}
