import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../controllador/tiponame.dart';
import '../repository/bddeuda.dart';

class deuda implements Repository<deuda> {
  bddeuda bddeu = bddeuda();
  //var
  int iddeuda = 0;
  tiponame tipname = tiponame.fromJson({});
  int idusuario = 0;
  double monto = 0.0;
  String fecha = "0000-00-00";
  String descripccion = "desconocido";
  int iddepentdeuda = 0;

  int get getiddeuda => iddeuda;
  tiponame get gettipname => tipname;
  int get getidusuario => idusuario;
  double get getmonto => monto;
  String get getfecha => fecha;
  String get getdescripccion => descripccion;
  int get getiddepentdeuda => iddepentdeuda;

  deuda.fromJson(Map<String, dynamic> json) {
    iddeuda = json.containsKey("id_deuda") ? json["id_deuda"] : 0;
    tipname = tiponame.fromJson({
      "id_gasto_tipo":
          json.containsKey("id_gasto_tipo") ? json["id_gasto_tipo"] : 0,
      "gastotipo":
          json.containsKey("gastotipo") ? json["gastotipo"] : "desconocido",
    });
    idusuario = json.containsKey("id_usuario") ? json["id_usuario"] : 0;
    monto = json.containsKey("monto") ? json["monto"] * 1.0 : 0.0;
    fecha = json.containsKey("fecha") ? json["fecha"] : "0000-00-00";
    descripccion =
        json.containsKey("descripccion") ? json["descripccion"] : "desconocido";
    iddepentdeuda =
        json.containsKey("id_depent_deuda") ? json["id_depent_deuda"] : 0;
  }

  Future<List<deuda>> getlist(deuda deu, Map<String, dynamic> jsonAtri) async {
    return bddeu.getlist(deu, jsonAtri);
  }

  Future<double> montototalgasto(
      deuda deud, Map<String, dynamic> jsonAtri) async {
    return bddeu.montototalgasto(deud, jsonAtri);
  }

  Future<int> insert(deuda deu, Map<String, dynamic> jsonAtri) async {
    return bddeu.insert(deu, jsonAtri);
  }

  Future<deuda> read(deuda deu, Map<String, dynamic> jsonAtri) async {
    return bddeu.read(deu, jsonAtri);
  }

  Future<int> delect(deuda deu, Map<String, dynamic> jsonAtri) async {
    return bddeu.delect(deu, jsonAtri);
  }

  Future<int> update(deuda deu, Map<String, dynamic> jsonAtri) async {
    return bddeu.update(deu, jsonAtri);
  }

  // Extrae las deudas programadas en un mes
  Future<List<fechacdeuda>> listfechadeuda(
      deuda deud, Map<String, dynamic> jsonAtri) async {
    return bddeu.listfechadeuda(deud, jsonAtri);
  }

  Future<List<Analiticgasto>> analitic(
      deuda deud, Map<String, dynamic> jsonAtri) async {
    switch ((jsonAtri['tipo'] as int)) {
      case 0:
        return bddeu.analiticPorcenGastoCategori(deud, jsonAtri);
      case 1:
        return bddeu.analiticGastoMensual(deud, jsonAtri);
      default:
        return [];
    }
  }
}

// con este objeto se va a realizar el analizis en el apartado de Analisisgasto
class Analiticgasto {
  //primer tipo de analisis
  double porcentag = 0;
  tiponame name = tiponame.fromJson({});
  // sengundo tipo de analisis
  String fecha = "";
  double monto = 0.0;

  double get getporcent => porcentag;
  tiponame get getname => name;
  String get getfecha => fecha;
  double get getmonto => monto;

  Analiticgasto.fromJson(Map<String, dynamic> json) {
    porcentag = json.containsKey("porcentaje") ? json["porcentaje"] * 1.0 : 0.0;
    name = tiponame.fromJson({
      "id_gasto_tipo":
          json.containsKey("id_gasto_tipo") ? json["id_gasto_tipo"] : 0,
      "gastotipo":
          json.containsKey("gastotipo") ? json["gastotipo"] : "desconocido",
    });
    //--------------------------------------------------------------------------
    fecha = json.containsKey("fecha_anal") ? json["fecha_anal"] : "";
    monto = json.containsKey("monto") ? json["monto"] * 1.0 : 0.0;
  }
}

// esto se puede usar para que genere los expandibles en el frond en el apartado
// de deudaprogramada
class fechacdeuda {
  // sengundo tipo de analisis
  String year = "";
  String month = "";
  double monto_tot = 0.0;

  String get getfecha => year;
  String get getmonth => month;
  double get getmonto => monto_tot;

  fechacdeuda.fromJson(Map<String, dynamic> json) {
    //--------------------------------------------------------------------------
    year = json.containsKey("year") ? json["year"] : "";
    month = json.containsKey("mont") ? json["mont"] : "";
    monto_tot = json.containsKey("monto_tot") ? json["monto_tot"] * 1.0 : 0.0;
  }
}
