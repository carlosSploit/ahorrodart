import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../repository/bdtiponame.dart';

class tiponame implements Repository<tiponame> {
  bdtiponame bdtipnam = bdtiponame();
  //var
  int idgastotipo = 0;
  String gastotipo = "desconocido";

  int get getidgastotipo => idgastotipo;
  String get getgastotipo => gastotipo;

  tiponame.fromJson(Map<String, dynamic> json) {
    idgastotipo = json.containsKey("id_gasto_tipo") ? json["id_gasto_tipo"] : 0;
    gastotipo = json.containsKey("gastotipo")
        ? json["gastotipo"].toString()
        : "desconocido";
  }

  Future<List<tiponame>> getlist(
      tiponame tipname, Map<String, dynamic> jsonAtri) async {
    return bdtipnam.getlist(tipname, jsonAtri);
  }

  Future<int> insert(tiponame tipname, Map<String, dynamic> jsonAtri) async {
    return bdtipnam.insert(tipname, jsonAtri);
  }

  Future<tiponame> read(tiponame tipname, Map<String, dynamic> jsonAtri) async {
    return bdtipnam.read(tipname, jsonAtri);
  }

  Future<int> delect(tiponame tipname, Map<String, dynamic> jsonAtri) async {
    return bdtipnam.delect(tipname, jsonAtri);
  }

  Future<int> update(tiponame tipname, Map<String, dynamic> jsonAtri) async {
    return bdtipnam.update(tipname, jsonAtri);
  }
}
