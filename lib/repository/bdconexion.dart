import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ignore: camel_case_types
class bd {
  // create table en fecha
  static String fecha = "CREATE TABLE fecha (" +
      "id_fecha INTEGER PRIMARY KEY," +
      "mes INTEGER NULL," +
      "ano INTEGER)";
  // create table en deuda
  static String deuda = "CREATE TABLE deuda (" +
      "id_deuda INTEGER PRIMARY KEY," +
      "monto DECIMAL(10,2)," +
      "descripccion TEXT," +
      "id_fecha INTEGER," +
      "dia INTEGER," +
      "id_name_tipo INTEGER," +
      "id_config INTEGER,)";
  // create table en confi_user
  static String confiuser = "CREATE TABLE confiuser (" +
      "id_confi INTEGER PRIMARY KEY," +
      "id_confi_coin INTEGER," +
      "id_usuario INTEGER)";
  // create table en confi_coin
  static String conficoin = "CREATE TABLE conficoin (" +
      "id_confi_coin INTEGER PRIMARY KEY," +
      "monto_t DECIMAL(10,2)," +
      "monto_ahorro DECIMAL(10,2)," +
      "monto_init DECIMAL(10,2))";
  // create table en usuario
  static String usuario = "CREATE TABLE usuario (" +
      "id_usuario INTEGER PRIMARY KEY," +
      "code_name TEXT," +
      "name TEXT)";

  bd();

  static Future<Database> openDB() async {
    return openDatabase(join(await getDatabasesPath(), "datosdb.db"),
        onCreate: (db, version) {
      db.execute("$fecha");
      db.execute("$deuda");
      db.execute("$confiuser");
      db.execute("$conficoin");
      db.execute("$usuario");
      return;
    }, version: 4);
  }

  // static Future<int> insert(Map<String, dynamic> jsonAtri) async {
  //   Database database = await _openDB();
  //   return database.insert("datosusuario", jsonAtri);
  // }

  // static Future<int> update(Map<String, dynamic> jsonAtri) async {
  //   Database database = await _openDB();
  //   return database
  //       .update("datosusuario", jsonAtri, where: "id = ?", whereArgs: [1]);
  // }

  // static Future<int> delect(Map<String, dynamic> jsonAtri) async {
  //   Datosuser datosnulos = Datosuser.fromJson({});
  //   Database database = await _openDB();
  //   return database.update("datosusuario", datosnulos.toJson(),
  //       where: "id = ?", whereArgs: [1]);
  // }

  // static Future<List<Datosuser>> list() async {
  //   Database database = await _openDB();
  //   // ignore: non_constant_identifier_names
  //   final List<Map<String, dynamic>> Datosusermap =
  //       await database.query("datosusuario");

  //   return List.generate(
  //     Datosusermap.length,
  //     (index) => Datosuser.fromJson({
  //       "idclient": Datosusermap[index]['idclient'],
  //       "idtrabajador": Datosusermap[index]['idtrabajador'],
  //       "idcarrito": Datosusermap[index]['idcarrito'],
  //       "iduser": Datosusermap[index]['iduser'],
  //       "tipouse": Datosusermap[index]['tipouse']
  //     }),
  //   );
  // }

  // static Future<int> length() async {
  //   Database database = await _openDB();
  //   // ignore: non_constant_identifier_names
  //   final List<Map<String, dynamic>> Datosusermap =
  //       await database.query("datosusuario");

  //   return Datosusermap.length;
  // }
}
