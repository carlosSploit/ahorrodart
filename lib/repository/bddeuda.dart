import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import 'bdconexion.dart';

class bddeuda implements Repository<Object> {
  Future<List<Object>> getlist(Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return [];
  }

  Future<int> insert(Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return database.insert("datosusuario", jsonAtri);
  }

  Future<int> read(Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return 0;
  }

  Future<int> delect(Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return 0;
  }

  Future<int> update(Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return 0;
  }
}
