class UserModel {
  String uid;
  String? email;
  String? fullName;
  String? gender;
  String? phoneNumber;
  String? photoURL;

  UserModel(
      {required this.uid,
      this.email,
      this.fullName,
      this.gender,
      this.phoneNumber,
      this.photoURL});
}
