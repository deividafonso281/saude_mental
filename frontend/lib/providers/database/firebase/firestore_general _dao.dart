import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../models/base_model.dart';
import '../../../models/convertos/map_converter_factory.dart';
import '../database_service.dart';
import 'paths/firestore_paths.dart';
import 'firestore_service.dart';

String documentIdFromCurrentDate() => DateTime.now().toIso8601String();

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
  FirestoreDao({required this.uid}) : assert(uid != null);
  final String uid;

  final _firestoreService = FirestoreService.instance;
  final _modelConverter = MapConverters.mapConverter<ModelT>();

  //Method to create/update ModelT
  @override
  Future<void> setData(ModelT todo) async => await _firestoreService.set(
        path: FirestorePath.entity(uid, "users", todo.id),
        data: _modelConverter.toMap(todo),
      );

  //Method to delete todoModel entry
  @override
  Future<void> deleteData(ModelT todo) async {
    await _firestoreService.deleteData(
        path: FirestorePath.entity(uid, "users", todo.id));
  }

  //Method to retrieve todoModel object based on the given todoId
  @override
  Stream<ModelT> dataStream({required String todoId}) =>
      _firestoreService.documentStream(
        path: FirestorePath.entity(uid, "users", todoId),
        builder: (data, documentId) =>
            _modelConverter.fromMap(data, documentId),
      );

  //Method to retrieve all todos item from the same user based on uid
  @override
  Stream<List<ModelT>> dataListStream() => _firestoreService.collectionStream(
        path: FirestorePath.collection(uid, "users"),
        builder: (data, documentId) =>
            _modelConverter.fromMap(data, documentId),
      );

  //Method to mark all ModelT to be complete
  @override
  Future<void> setAllDataComplete() async {
    final batchUpdate = FirebaseFirestore.instance.batch();

    final querySnapshot = await FirebaseFirestore.instance
        .collection(FirestorePath.collection(uid, "users"))
        .get();

    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchUpdate.update(ds.reference, {'complete': true});
    }
    await batchUpdate.commit();
  }

  @override
  Future<void> deleteAllDataWithComplete() async {
    final batchDelete = FirebaseFirestore.instance.batch();

    final querySnapshot = await FirebaseFirestore.instance
        .collection(FirestorePath.collection(uid, "users"))
        .where('complete', isEqualTo: true)
        .get();

    for (DocumentSnapshot ds in querySnapshot.docs) {
      batchDelete.delete(ds.reference);
    }
    await batchDelete.commit();
  }
}
