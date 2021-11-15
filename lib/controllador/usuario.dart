import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../repository/bdusuario.dart';

class usuario implements Repository<usuario> {
  bdusuario bduser = bdusuario();
  //var
  int idusuario = 0;
  String codename = "00000000";
  String name = "desconocido";
  String photo =
      "https://i.pinimg.com/736x/38/d4/b1/38d4b11793d3ce60de5c34d5abb2f7b2.jpg";

  usuario.fromJson(Map<String, dynamic> json) {
    idusuario = json.containsKey("id_usuario") ? json["id_usuario"] : 0;
    codename = json.containsKey("code_name") ? json["code_name"] : "00000000";
    name = json.containsKey("name") ? json["name"] : "desconocido";
    photo = json.containsKey("photo")
        ? json["photo"]
        : "https://i.pinimg.com/736x/38/d4/b1/38d4b11793d3ce60de5c34d5abb2f7b2.jpg";
  }

  int get getidusuario => idusuario;
  String get getcodename => codename;
  String get getname => name;
  String get getphoto => photo;

  Future<List<usuario>> getlist(
      usuario usua, Map<String, dynamic> jsonAtri) async {
    return bduser.getlist(usua, jsonAtri);
  }

  Future<int> userconnet() async {
    List<usuario> listus = await getlist(usuario.fromJson({}), {});
    if (listus.length != 0) {
      return listus[0].getidusuario;
    }
    return 0;
  }

  Future<int> insert(usuario usua, Map<String, dynamic> jsonAtri) async {
    return bduser.insert(usua, jsonAtri);
  }

  Future<usuario> read(usuario usua, Map<String, dynamic> jsonAtri) async {
    return bduser.read(usua, jsonAtri);
  }

  Future<int> delect(usuario usua, Map<String, dynamic> jsonAtri) async {
    return bduser.delect(usua, jsonAtri);
  }

  Future<int> update(usuario usua, Map<String, dynamic> jsonAtri) async {
    return bduser.update(usua, jsonAtri);
  }
}
