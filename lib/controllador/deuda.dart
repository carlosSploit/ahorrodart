import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../repository/bddeuda.dart';

class deuda implements Repository<Object> {
  bddeuda bddeu = bddeuda();

  Future<List<Object>> getlist(Map<String, dynamic> jsonAtri) async {
    return bddeu.getlist(jsonAtri);
  }

  Future<int> insert(Map<String, dynamic> jsonAtri) async {
    return bddeu.insert(jsonAtri);
  }

  Future<int> read(Map<String, dynamic> jsonAtri) async {
    return bddeu.read(jsonAtri);
  }

  Future<int> delect(Map<String, dynamic> jsonAtri) async {
    return bddeu.delect(jsonAtri);
  }

  Future<int> update(Map<String, dynamic> jsonAtri) async {
    return bddeu.update(jsonAtri);
  }
}
