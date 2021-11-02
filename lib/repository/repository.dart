abstract class Repository<T> {
  Future<List<T>> getlist(Map<String, dynamic> jsonAtri);
  Future<int> insert(Map<String, dynamic> jsonAtri);
  Future<int> read(Map<String, dynamic> jsonAtri);
  Future<int> delect(Map<String, dynamic> jsonAtri);
  Future<int> update(Map<String, dynamic> jsonAtri);
  // Future<T> read(Map<String, dynamic> jsonAtri);
}
