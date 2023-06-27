import 'package:frontend/models/convertos/map_converter_interface.dart';
import 'package:frontend/models/user_model.dart';

class EspecialistModelConverter implements MapConverter<EspecialistModel> {
  @override
  EspecialistModel fromMap(Map<String, dynamic> json, String id) {
    return EspecialistModel(
      id: id,
      email: json["email"],
      fullName: json["fullName"],
      gender: stringToGender(json["gender"]),
      phoneNumber: json["phoneNumber"],
      CRP: json["CRP"],
      especialization: stringToEspscialization(json["especialization"]),
      bios: json["bios"],
      latitude: json["latitude"],
      longitude: json["longitude"],
      address: json["address"],
      agenda: json["agenda"],
    );
  }

  @override
  Map<String, dynamic> toMap(EspecialistModel model) {
    return {
      "id": model.id,
      "email": model.email,
      "fullName": model.fullName,
      "gender": model.gender.toShortString(),
      "phoneNumber": model.phoneNumber,
      "CRP": model.CRP,
      "bios": model.bios,
      "latitude": model.latitude,
      "longitude": model.longitude,
      "especialization": model.especialization.toShortString(),
      "address": model.address,
      "agenda": model.toString(),
    };
  }
}

class EspecialistModel extends UserModel {
  Especialization especialization;
  String CRP;
  String bios;

  EspecialistModel({
    required this.especialization,
    required this.CRP,
    required this.bios,
    required super.id,
    required super.email,
    required super.fullName,
    required super.gender,
    required super.phoneNumber,
    required super.latitude,
    required super.longitude,
    required super.address,
    required super.agenda,
  });
}

enum Especialization {
  PSC_CLINICA,
  PSC_HOSPITAlAR,
  PSC_JURIDICA,
}

extension ParseToString on Especialization {
  String toShortString() {
    switch (this) {
      case Especialization.PSC_CLINICA:
        return "Pisicologo clinica";
      case Especialization.PSC_HOSPITAlAR:
        return "Pisicologo Hospitalara";
      case Especialization.PSC_JURIDICA:
        return "Pisicologo Juridica";
      default:
        return "";
    }
  }
}

List<String> especializationToStringList() {
  return Especialization.values.map((esp) => esp.toShortString()).toList();
}

Especialization stringToEspscialization(String esp) {
  switch (esp) {
    case "Pisicologo clinica":
      return Especialization.PSC_CLINICA;
    case "Pisicologo Hospitalara":
      return Especialization.PSC_HOSPITAlAR;
    case "Pisicologo Juridica":
      return Especialization.PSC_JURIDICA;
    default:
      return Especialization.PSC_CLINICA;
  }
}
