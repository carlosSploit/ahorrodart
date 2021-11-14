import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../controllador/tiponame.dart';
import 'bdconexion.dart';

class bdtiponame implements Repository<tiponame> {
  Future<List<tiponame>> getlist(
      tiponame tipn, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    List<Map<String, dynamic>> Datosusermap =
        await database.rawQuery('''SELECT * FROM tipogasto''');
    //---------------------------------------------------
    print("print bd - ${Datosusermap.length}");
    print(Datosusermap);
    return List.generate(Datosusermap.length, (index) {
      return tiponame.fromJson({
        "id_gasto_tipo": Datosusermap[index]['id_gasto_tipo'],
        "gastotipo": Datosusermap[index]['gastotipo']
      });
    });
  }

  Future<int> insert(tiponame tipn, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return 0;
  }

  Future<tiponame> read(tiponame tipn, Map<String, dynamic> jsonAtri) async {
    tiponame tipnam = tiponame.fromJson({});
    Database database = await bd.openDB();
    return tipnam;
  }

  Future<int> delect(tiponame tipn, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return 0;
  }

  Future<int> update(tiponame tipn, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return 0;
  }
}
