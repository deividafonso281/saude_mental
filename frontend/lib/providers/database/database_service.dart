abstract class DataBase<Model> {
  Future<void> setData(Model todo);
  Future<void> deleteData(Model todo);
  Stream<Model> dataStream({required String todoId});
  Future<Model> getById({required String modelId});
  Stream<List<Model>> dataListStream();
  Future<void> setAllDataComplete();
  Future<void> deleteAllDataWithComplete();
}
