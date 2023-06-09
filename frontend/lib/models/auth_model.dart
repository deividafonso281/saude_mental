class AuthModel {
  String uid;
  String? email;
  UserType? userType;

  AuthModel({
    required this.uid,
    this.email,
    this.userType,
  });
}

enum UserType {
  Patient,
  Especialist,
}

extension ParseToString on UserType {
  String toShortString() {
    switch (this) {
      case UserType.Especialist:
        return "Especialist";
      case UserType.Patient:
        return "Patient";
      default:
        return "";
    }
  }
}

UserType stringToUserType(String userType) {
  switch (userType) {
    case "Patient":
      return UserType.Patient;
    case "Especialist":
      return UserType.Especialist;
    default:
      return UserType.Patient;
  }
}
