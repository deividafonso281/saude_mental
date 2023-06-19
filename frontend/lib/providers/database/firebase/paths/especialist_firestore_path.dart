import 'package:frontend/models/especialist_model.dart';
import 'package:frontend/providers/database/firebase/paths/firestore_paths_interface.dart';

class EspecialistPath extends Paths<EspecialistModel> {
  @override
  String collection() {
    return "especialista/";
  }

  @override
  String entity(String id) {
    return "especialista/$id";
  }
}
