import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../repository/bdconfiuser.dart';

class confiuser implements Repository<Object> {
  bdconfiuser bdconfuse = bdconfiuser();
  //vars table
  int id_fecha = 0;
  int mes = 0;
  int ano = 0;

  int get getidfecha => id_fecha;
  int get getmes => id_fecha;
  int get getano => id_fecha;

  confiuser.fromJson(Map<String, dynamic> json) {
    id_fecha = json.containsKey("id_fecha") ? json["id_fecha"] : 0;
    mes = json.containsKey("mes") ? json["id_fecha"] : 0;
    ano = json.containsKey("ano") ? json["id_fecha"] : 0;
  }

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
