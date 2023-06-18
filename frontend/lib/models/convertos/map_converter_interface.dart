abstract class MapConverter<T> {
  Map<String, dynamic> toMap(T model);
  T fromMap(Map<String, dynamic> json, String id);
}
