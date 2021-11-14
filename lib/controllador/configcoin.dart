import 'package:ahorrobasic/repository/repository.dart';
import '../repository/bdconfigcoin.dart';
import 'package:sqflite/sqflite.dart';

class configcoin implements Repository<configcoin> {
  bdconfigcoin bdcoin = bdconfigcoin();
  //vars table
  int idconfigcoin = 0;
  double montot = 0.0;
  double montoahorro = 0.0;
  double montoinit = 0.0;
  int idusuario = 0;
  String fecha = "00/00/0000";

  int get getidconfcoin => idconfigcoin;
  double get getmontot => montot;
  double get getmontoah => montoahorro;
  double get getmontoini => montoinit;
  int get getidusuario => idusuario;
  String get getfecha => fecha;

  set setidconfcoin(int i) => {idconfigcoin = i};
  set setmontot(double i) => {montot = i};
  set setmontoah(double i) => {montoahorro = i};
  set setmontoini(double i) => {montoinit = i};
  set setidusuario(int i) => {idusuario = i};
  set setfecha(String i) => {fecha = i};

  configcoin.fromJson(Map<String, dynamic> json) {
    idconfigcoin =
        json.containsKey("id_config_coin") ? json["id_config_coin"] : 0;
    montot = json.containsKey("monto_t") ? json["monto_t"] * 1.0 : 0.0;
    montoahorro =
        json.containsKey("monto_ahorro") ? json["monto_ahorro"] * 1.0 : 0.0;
    montoinit = json.containsKey("monto_init") ? json["monto_init"] * 1.0 : 0.0;
    idusuario = json.containsKey("id_usuario ") ? json["id_usuario"] : 0;
    fecha = json.containsKey("fecha ") ? json["fecha"] : "0000-00-00";
  }

  Future<List<configcoin>> getlist(
      configcoin coin, Map<String, dynamic> jsonAtri) async {
    return bdcoin.getlist(coin, jsonAtri);
  }

  Future<int> insert(configcoin coin, Map<String, dynamic> jsonAtri) async {
    // por obligacion este tiene que retornar un dijito
    return bdcoin.insert(coin, jsonAtri);
  }

  Future<configcoin> read(
      configcoin coin, Map<String, dynamic> jsonAtri) async {
    // se ingresa 0 para saber su la configuacion actual
    if (coin.getidconfcoin == 0) {
      final List<configcoin> Datosusresul =
          await bdcoin.getlist(coin, {"tipo": 0});
      // si existe una configuracion para este mes, solo bota el dato
      if (Datosusresul.length != 0) {
        print("Si hay una configuacion inicializada");
        print("${Datosusresul[0].getidconfcoin}");
        return bdcoin.read(
            configcoin
                .fromJson({"id_config_coin": (Datosusresul[0].getidconfcoin)}),
            jsonAtri);
      } else {
        // si no existe, se ingresa el anterior mes como historial
        final List<configcoin> Datosusresul =
            await bdcoin.getlist(coin, {"tipo": 1});
        // si existe el mes anterior, enviamos datos  insertar como un mes actual
        if (Datosusresul.length != 0) {
          configcoin confic = await read(
              configcoin.fromJson(
                  {"id_config_coin": (Datosusresul[0].getidconfcoin)}),
              jsonAtri);
          print("Si hay una configuacion anterior y pasara a la actual");
          await insert(confic, jsonAtri);
          return confic;
        } else {
          //si no existe un mes anterior, es porque no hay usuarios en el sistema
          configcoin confic = configcoin.fromJson({
            "id_config_coin": 1,
            "id_usuario": 1,
            "fecha": "0000-00-00",
            "monto_t": 1000,
            "monto_ahorro": 10,
            "monto_init": 1010,
          });
          print("recin esta empesando la aplicacion desde 0");
          await insert(confic, jsonAtri);
          return confic;
        }
      }
    }
    return bdcoin.read(coin, jsonAtri);
  }

  Future<int> delect(configcoin coin, Map<String, dynamic> jsonAtri) async {
    return bdcoin.delect(coin, jsonAtri);
  }

  Future<int> update(configcoin coin, Map<String, dynamic> jsonAtri) async {
    return bdcoin.update(coin, jsonAtri);
  }

  Future<List<Analiticconfigcoin>> analitic(
      configcoin conf, Map<String, dynamic> jsonAtri) async {
    return bdcoin.analiticAhorroMensual(conf, jsonAtri);
  }
}

class Analiticconfigcoin {
  // sengundo tipo de analisis
  String fecha = "";
  double ahorro = 0.0;

  String get getfecha => fecha;
  double get getahorro => ahorro;

  Analiticconfigcoin.fromJson(Map<String, dynamic> json) {
    //--------------------------------------------------------------------------
    fecha = json.containsKey("fecha_anal") ? json["fecha_anal"] : "202111";
    ahorro = json.containsKey("ahorro") ? json["ahorro"] * 1.0 : 0.0;
  }
}
