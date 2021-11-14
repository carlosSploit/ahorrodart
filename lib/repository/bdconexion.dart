import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// ignore: camel_case_types
class bd {
  // create table en deuda
  static String deuda = "CREATE TABLE deuda (" +
      "id_deuda INTEGER PRIMARY KEY," +
      "monto DECIMAL(10,2)," +
      "descripccion TEXT," +
      "fecha TEXT," +
      "id_gasto_tipo INTEGER," +
      "id_depent_deuda INTEGER," +
      "id_usuario INTEGER)";

  // create table en confi_coin
  static String conficoin = "CREATE TABLE conficoin (" +
      "id_confi_coin INTEGER PRIMARY KEY," +
      "monto_t DECIMAL(10,2)," +
      "monto_ahorro DECIMAL(10,2)," +
      "monto_init DECIMAL(10,2)," +
      "id_usuario INTEGER," +
      "fecha TEXT)";
  // create table en usuario
  static String usuario = '''CREATE TABLE usuario (
      id_usuario INTEGER PRIMARY KEY,
      code_name TEXT,
      name TEXT,
      estade BLOB
      )''';
  static String tipogasto = '''CREATE TABLE tipogasto (
      id_gasto_tipo INTEGER PRIMARY KEY,
      gastotipo TEXT
      )''';

  bd();

  static Future<Database> openDB() async {
    return openDatabase(join(await getDatabasesPath(), "datosdb7.db"),
        onCreate: (db, version) async {
      // eliminar tablas si esque existen
      db.execute("DROP TABLE IF EXISTS tipogasto;");
      db.execute("DROP TABLE IF EXISTS deuda;");
      db.execute("DROP TABLE IF EXISTS conficoin;");
      db.execute("DROP TABLE IF EXISTS usuario;");
      //--------------------------------------------
      db.execute("$deuda");
      db.execute("$conficoin");
      db.execute("$usuario");
      db.execute("$tipogasto");
      // comprobador de tablas creadas
      List<Map<String, dynamic>> Datosusermap = await db
          .rawQuery("SELECT name FROM sqlite_master WHERE type='table';");
      print("${Datosusermap}-------------------");

      Datosusermap = await db.rawQuery("pragma table_info(tipogasto);");
      print("${Datosusermap}-------------------");
      // Datosusermap = await db.rawQuery("pragma table_info(deuda);");
      // print("${Datosusermap}-------------------");
      // Datosusermap = await db.rawQuery("pragma table_info(conficoin);");
      // print("${Datosusermap}-------------------");
      // Datosusermap = await db.rawQuery("pragma table_info(usuario);");
      // print("${Datosusermap}-------------------");

      // inicializar variables
      // crea tipos de gastos
      db.execute(
          "INSERT INTO tipogasto (gastotipo) VALUES('Compras a credito');");
      db.execute(
          "INSERT INTO tipogasto (gastotipo) VALUES('Compras al contado');");
      db.execute(
          "INSERT INTO tipogasto (gastotipo) VALUES('Pagos de servicios');");
      db.execute(
          "INSERT INTO tipogasto (gastotipo) VALUES('Pagos de tarjetas');");
      // crea primer usuarios
      db.execute(
          "INSERT INTO usuario (code_name,name,estade) VALUES('1465468','carlos arturo guerrero castillo',1);");
      //--------------------------------------------
      print("se comenzo a crear");
      return;
    }, onOpen: (db) async {
      final List<Map<String, dynamic>> Datosusermap = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name='conficoin';");
      print("${Datosusermap[0]["name"]}-------------------");
      print("${await getDatabasesPath()}");
    }, version: 1);
  }

  // convierte un numeor como 1 a dos caracteres como 01
  static String convertuncaddoscar(int a) {
    return (a < 10) ? "0$a" : a.toString();
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
