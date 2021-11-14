abstract class Repository<T> {
  Future<List<T>> getlist(T obj, Map<String, dynamic> jsonAtri);
  Future<int> insert(T obj, Map<String, dynamic> jsonAtri);
  Future<T> read(T obj, Map<String, dynamic> jsonAtri);
  Future<int> delect(T obj, Map<String, dynamic> jsonAtri);
  Future<int> update(T obj, Map<String, dynamic> jsonAtri);
  // Future<T> read(Map<String, dynamic> jsonAtri);
}
