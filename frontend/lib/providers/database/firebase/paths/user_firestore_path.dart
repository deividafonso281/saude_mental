import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/database/firebase/paths/firestore_paths_interface.dart';

class UserPath extends Paths<UserModel> {
  @override
  String collection() {
    return "paciente/";
  }

  @override
  String entity(String id) {
    return "paciente/$id";
  }
}
