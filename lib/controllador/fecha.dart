import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../repository/bdfecha.dart';

class fecha implements Repository<Object> {
  bdfecha bdfech = bdfecha();

  Future<List<Object>> getlist(Map<String, dynamic> jsonAtri) async {
    return bdfech.getlist(jsonAtri);
  }

  Future<int> insert(Map<String, dynamic> jsonAtri) async {
    return bdfech.insert(jsonAtri);
  }

  Future<int> read(Map<String, dynamic> jsonAtri) async {
    return bdfech.read(jsonAtri);
  }

  Future<int> delect(Map<String, dynamic> jsonAtri) async {
    return bdfech.delect(jsonAtri);
  }

  Future<int> update(Map<String, dynamic> jsonAtri) async {
    return bdfech.update(jsonAtri);
  }
}
