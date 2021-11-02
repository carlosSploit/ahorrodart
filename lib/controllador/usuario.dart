import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../repository/bdusuario.dart';

class usuario implements Repository<Object> {
  bdusuario bduser = bdusuario();

  Future<List<Object>> getlist(Map<String, dynamic> jsonAtri) async {
    return bduser.getlist(jsonAtri);
  }

  Future<int> insert(Map<String, dynamic> jsonAtri) async {
    return bduser.insert(jsonAtri);
  }

  Future<int> read(Map<String, dynamic> jsonAtri) async {
    return bduser.read(jsonAtri);
  }

  Future<int> delect(Map<String, dynamic> jsonAtri) async {
    return bduser.delect(jsonAtri);
  }

  Future<int> update(Map<String, dynamic> jsonAtri) async {
    return bduser.update(jsonAtri);
  }
}
