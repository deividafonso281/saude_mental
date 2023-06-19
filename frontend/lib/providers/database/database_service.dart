abstract class DataBase<Model> {
  Future<void> setData(Model todo);
  Future<void> deleteData(Model todo);
  Stream<Model> dataStream({required String todoId});
  Stream<List<Model>> dataListStream();
  Future<void> setAllDataComplete();
  Future<void> deleteAllDataWithComplete();
}
