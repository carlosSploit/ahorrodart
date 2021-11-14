import 'package:ahorrobasic/repository/repository.dart';
import '../controllador/configcoin.dart';
import '../controllador/usuario.dart';
import 'package:sqflite/sqflite.dart';
import 'bdconexion.dart';

class bdconfigcoin implements Repository<configcoin> {
  // la seleccion se esta realizando sin un usuario
  // tener en cuenta eso
  Future<List<configcoin>> getlist(
      configcoin conf, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    // extraer el ultimo video
    //----------------- consulta sql -------------------
    usuario uax = usuario.fromJson({});
    int idusuario = await uax.userconnet();
    //------------------
    if (jsonAtri["tipo"] == 0) {
      List<Map<String, dynamic>> Datosusermap =
          await database.rawQuery('''SELECT id_confi_coin 
                  FROM conficoin 
                  WHERE strftime('%m','now') = strftime('%m', fecha) 
                  AND strftime('%Y','now') = strftime('%Y', fecha)
                  AND id_usuario  = ${idusuario} ORDER BY id_confi_coin  DESC LIMIT 1;''');
      //---------------------------------------------------
      print("print bd - ${Datosusermap.length}");
      print(Datosusermap);
      print(
          "${(Datosusermap.length != 0) ? Datosusermap[0]['id_config_coin'] : "ERROR PARECE QUE ESTA BACIO"}");
      //Datosusermap = listmesactual(Datosusermap);
      return List.generate(Datosusermap.length, (index) {
        return configcoin.fromJson({
          "id_config_coin": Datosusermap[index]['id_confi_coin'],
        });
      });
    } else {
      final List<Map<String, dynamic>> Datosusermap =
          await database.rawQuery('''SELECT id_confi_coin 
          FROM conficoin 
          WHERE strftime('%Y','now') = strftime('%Y', fecha)
          AND id_usuario  = ${idusuario} ORDER BY id_confi_coin  DESC LIMIT 1, 1;''');
      return List.generate(
        Datosusermap.length,
        (index) => configcoin.fromJson({
          "id_config_coin": Datosusermap[index]['id_config_coin'],
        }),
      );
    }
  }

  // se hace un flitro de los datos entrantes y se extrae los que presenta:
  // - una fecha actual
  List<Map<String, dynamic>> listmesactual(
      List<Map<String, dynamic>> lisdatos) {
    List<Map<String, dynamic>> resul = [];
    // filtro con la cecha actual
    for (Map<String, dynamic> item in lisdatos) {
      List<String> fecha = (item['fecha'] as String).split("-");
      if (((int.parse(fecha[0])) == DateTime.now().year) &&
          ((int.parse(fecha[1])) == DateTime.now().month)) {
        resul.add(item);
      }
    }
    return resul;
  }

  Future<int> insert(configcoin conf, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    //-----------------------------------------
    usuario uax = usuario.fromJson({});
    int idusuario = await uax.userconnet();
    //-----------------------------------------
    await database.rawInsert(
      "INSERT INTO conficoin ( monto_ahorro , monto_init , monto_t , fecha , id_usuario ) VALUES ( ${conf.getmontoah} , ${conf.getmontoini} , ${conf.getmontot} , '${DateTime.now().year}-${bd.convertuncaddoscar(DateTime.now().month)}-${bd.convertuncaddoscar(DateTime.now().day)}' , ${idusuario} );",
    );
    await database.close();
    print(
        "se ingreso a insertar con los tados monto_ahorro - ${conf.getmontoah} monto_init - ${conf.getmontoini} monto_t - ${conf.getmontot}");
    return 0;
  }

  Future<configcoin> read(
      configcoin conf, Map<String, dynamic> jsonAtri) async {
    configcoin config = configcoin.fromJson({});
    Database database = await bd.openDB();
    print(conf.getidconfcoin);
    final List<Map<String, dynamic>> Datosusermap = await database.rawQuery(
        "SELECT * FROM conficoin WHERE id_confi_coin = ${conf.getidconfcoin};");
    return configcoin.fromJson({
      "id_config_coin": Datosusermap[0].containsKey("id_config_coin")
          ? Datosusermap[0]["id_config_coin"]
          : 0,
      "id_usuario": Datosusermap[0].containsKey("id_usuario")
          ? Datosusermap[0]["id_usuario"]
          : 0,
      "fecha": Datosusermap[0].containsKey("fecha ")
          ? Datosusermap[0]["fecha"]
          : "0000-00-00",
      "monto_t": Datosusermap[0].containsKey("monto_t")
          ? Datosusermap[0]["monto_t"]
          : 0.0,
      "monto_ahorro": Datosusermap[0].containsKey("monto_ahorro")
          ? Datosusermap[0]["monto_ahorro"]
          : 0.0,
      "monto_init": Datosusermap[0].containsKey("monto_init")
          ? Datosusermap[0]["monto_init"]
          : 0.0,
    });
  }

  Future<int> delect(configcoin conf, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return 0;
  }

  Future<int> update(configcoin conf, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    List<configcoin> listconif = await getlist(conf, {"tipo": 0});
    int idconfig = listconif[0].getidconfcoin;
    await database.rawUpdate(
        "UPDATE conficoin SET monto_init = ${conf.getmontoini} , monto_ahorro = ${conf.getmontoah} , monto_t = ${conf.getmontoini} - ${conf.getmontoah} WHERE id_confi_coin = ${idconfig};");
    return 0;
  }

  Future<List<Analiticconfigcoin>> analiticAhorroMensual(
      configcoin conf, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    //-----------------------------------------
    usuario uax = usuario.fromJson({});
    int idusuario = await uax.userconnet();
    //-----------------------------------------
    final List<Map<String, dynamic>> Datosusermap = await database.rawQuery(
        '''SELECT sum(monto_ahorro) as ahorro , strftime('%Y',fecha) || strftime('%m',fecha) as fecha_anal
            FROM conficoin
            WHERE id_usuario = ${idusuario}
            GROUP by fecha_anal LIMIT 5;
            ''');
    //---------------------------------------------------
    print("print bd deuda - ${Datosusermap.length}");
    print(Datosusermap);
    //---------------------------------------------------
    // generar la lista
    return List.generate(
      Datosusermap.length,
      (index) => Analiticconfigcoin.fromJson({
        "ahorro": Datosusermap[index]['ahorro'],
        "fecha_anal": Datosusermap[index]['fecha_anal'],
      }),
    );
  }
}
