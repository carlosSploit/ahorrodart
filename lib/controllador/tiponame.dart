import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../repository/bdtiponame.dart';

class tiponame implements Repository<Object> {
  bdtiponame bdtipnam = bdtiponame();

  Future<List<Object>> getlist(Map<String, dynamic> jsonAtri) async {
    return bdtipnam.getlist(jsonAtri);
  }

  Future<int> insert(Map<String, dynamic> jsonAtri) async {
    return bdtipnam.insert(jsonAtri);
  }

  Future<int> read(Map<String, dynamic> jsonAtri) async {
    return bdtipnam.read(jsonAtri);
  }

  Future<int> delect(Map<String, dynamic> jsonAtri) async {
    return bdtipnam.delect(jsonAtri);
  }

  Future<int> update(Map<String, dynamic> jsonAtri) async {
    return bdtipnam.update(jsonAtri);
  }
}
