import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../controllador/usuario.dart';
import 'bdconexion.dart';

class bdusuario implements Repository<usuario> {
  Future<List<usuario>> getlist(
      usuario us, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    List<Map<String, dynamic>> Datosusermap = [];

    if (us.getcodename.toString() == "00000000") {
      Datosusermap = await database
          .rawQuery('''SELECT * FROM usuario WHERE estade = 1 ''');
    } else {
      Datosusermap = await database.rawQuery(
          '''SELECT * FROM usuario WHERE code_name = '${us.getcodename.toString()}' ''');
    }
    //---------------------------------------------------
    print("print bd usuario - ${Datosusermap.length}");
    print(Datosusermap);
    if (Datosusermap.length != 0) {
      print("${Datosusermap[0]['id_usuario']}");
    }

    //---------------------------------------------------
    // generar la lista
    return List.generate(
      Datosusermap.length,
      (index) => usuario.fromJson({
        "id_usuario": Datosusermap[index]['id_usuario'],
        "photo": Datosusermap[index]['photo']
      }),
    );
  }

  Future<int> insert(usuario us, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return database.rawInsert(
        "INSERT INTO usuario (code_name,name,photo,estade) VALUES('${us.getcodename}','${us.getname}','${us.getphoto}',1);");
  }

  Future<usuario> read(usuario us, Map<String, dynamic> jsonAtri) async {
    usuario user = usuario.fromJson({});
    Database database = await bd.openDB();
    return user;
  }

  Future<int> delect(usuario us, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return 0;
  }

  Future<int> update(usuario us, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    if (us.getcodename == "00000000") {
      await database.rawUpdate(''' UPDATE usuario
                            SET estade = 0
                            WHERE 1; ''');
    } else {
      await database.rawUpdate(''' UPDATE usuario
                            SET estade = 1
                            WHERE code_name = '${us.getcodename}'; ''');
    }

    return 0;
  }
}
