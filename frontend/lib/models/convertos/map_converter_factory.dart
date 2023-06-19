// Importing cloud_firestore only for DartDoc intellisense
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/models/especialist_model.dart';

import '../user_model.dart';
import 'map_converter_interface.dart';

class MapConverters {
  static final Map<Type, MapConverter> _mapConverterMap = {
    EspecialistModel: EspecialistModelConverter(),
    UserModel: UserModelConverter(),
  };

  static MapConverter<T> mapConverter<T>() {
    return _mapConverterMap[T] as MapConverter<T>;
  }
}
