import 'package:frontend/models/especialist_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/providers/database/firebase/paths/especialist_firestore_path.dart';
import 'package:frontend/providers/database/firebase/paths/user_firestore_path.dart';

import 'firestore_paths_interface.dart';

class PathsFactory {
  static final Map<Type, Paths> _pathMap = {
    UserModel: UserPath(),
    EspecialistModel: EspecialistPath(),
  };

  static Paths<T> mapPaths<T>() {
    return _pathMap[T] as Paths<T>;
  }
}
