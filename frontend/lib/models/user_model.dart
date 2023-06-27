import 'dart:ffi';

import 'package:frontend/models/base_model.dart';
import 'package:frontend/models/convertos/map_converter_interface.dart';

class UserModelConverter implements MapConverter<UserModel> {
  @override
  UserModel fromMap(Map<String, dynamic> json, String id) {
    return UserModel(
      id: id,
      email: json["email"],
      fullName: json["fullName"],
      gender: stringToGender(json["gender"]),
      phoneNumber: json["phoneNumber"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      address: json["address"],
      imageUrl: json["imageUrl"]
    );
  }

  @override
  Map<String, dynamic> toMap(UserModel model) {
    return {
      "id": model.id,
      "email": model.email,
      "fullName": model.fullName,
      "gender": model.gender.toShortString(),
      "phoneNumber": model.phoneNumber,
      "latitude": model.latitude,
      "longitude": model.longitude,
      "address": model.address,
      "imageUrl": model.imageUrl
    };
  }
}

class UserModel extends BaseModel {
  String id;
  String email;
  String fullName;
  Gender gender;
  String phoneNumber;
  double latitude;
  double longitude;
  String address;
  String imageUrl;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.gender,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.imageUrl
  }) : super(id: id);
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

String genderToString(Gender gender) {
  switch (gender) {
    case Gender.Male:
      return "Masculino";
    case Gender.Female:
      return "Feminino";
    case Gender.NonBinary:
      return "Não Binario";
    default:
      return "Não Binario";
  }
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
