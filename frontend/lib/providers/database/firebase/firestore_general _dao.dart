import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:frontend/providers/database/firebase/paths/firestore_paths_factory.dart';
import '../../../models/base_model.dart';
import '../../../models/convertos/map_converter_factory.dart';
import '../database_service.dart';
import 'firestore_service.dart';

/*
This is the main class access/call for any UI widgets that require to perform
any CRUD activities operation in FirebaseFirestore database.
This class work hand-in-hand with FirestoreService and FirestorePath.

Notes:
For cases where you need to have a special method such as bulk update specifically
on a field, then is ok to use custom code and write it here. For example,
setAllTodoComplete is require to change all todos item to have the complete status
changed to true.
 */

class FirestoreDao<ModelT extends BaseModel> implements DataBase<ModelT> {
  final _firestoreService = FirestoreService.instance;
  final _modelConverter = MapConverters.mapConverter<ModelT>();
  final _paths = PathsFactory.mapPaths<ModelT>();

  //Method to create/update ModelT
  @override
  Future<void> setData(ModelT todo) async => await _firestoreService.set(
        path: _paths.entity(todo.id),
        data: _modelConverter.toMap(todo),
      );

  //Method to delete todoModel entry
  @override
  Future<void> deleteData(ModelT todo) async {
    await _firestoreService.deleteData(path: _paths.entity(todo.id));
  }

  //Method to retrieve todoModel object based on the given todoId
  @override
  Stream<ModelT> dataStream({required String todoId}) =>
      _firestoreService.documentStream(
        path: _paths.entity(todoId),
        builder: (data, documentId) =>
            _modelConverter.fromMap(data, documentId),
      );

  //Method to retrieve all todos item from the same user based on uid
  @override
  Stream<List<ModelT>> dataListStream() => _firestoreService.collectionStream(
        path: _paths.collection(),
        builder: (data, documentId) =>
            _modelConverter.fromMap(data, documentId),
      );

  //Method to mark all ModelT to be complete
  @override
  Future<void> setAllDataComplete() async {
    final batchUpdate = FirebaseFirestore.instance.batch();

    final querySnapshot =
        await FirebaseFirestore.instance.collection(_paths.collection()).get();

    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchUpdate.update(ds.reference, {'complete': true});
    }
    await batchUpdate.commit();
  }

  @override
  Future<void> deleteAllDataWithComplete() async {
    final batchDelete = FirebaseFirestore.instance.batch();

    final querySnapshot = await FirebaseFirestore.instance
        .collection(_paths.collection())
        .where('complete', isEqualTo: true)
        .get();

    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchDelete.delete(ds.reference);
    }
    await batchDelete.commit();
  }

   @override
  Future<ModelT> getById({required String modelId}) async {
    return await _firestoreService.getById(path: _paths.entity(modelId), builder: (data, id) => _modelConverter.fromMap(data, id));
  }
}
