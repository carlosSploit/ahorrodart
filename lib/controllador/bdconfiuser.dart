import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../repository/bdconfiuser.dart';

class confiuser implements Repository<Object> {
  bdconfiuser bdconfuse = bdconfiuser();

  Future<List<Object>> getlist(Map<String, dynamic> jsonAtri) async {
    return bdconfuse.getlist(jsonAtri);
  }

  Future<int> insert(Map<String, dynamic> jsonAtri) async {
    return bdconfuse.insert(jsonAtri);
  }

  Future<int> read(Map<String, dynamic> jsonAtri) async {
    return bdconfuse.read(jsonAtri);
  }

  Future<int> delect(Map<String, dynamic> jsonAtri) async {
    return bdconfuse.delect(jsonAtri);
  }

  Future<int> update(Map<String, dynamic> jsonAtri) async {
    return bdconfuse.update(jsonAtri);
  }
}
