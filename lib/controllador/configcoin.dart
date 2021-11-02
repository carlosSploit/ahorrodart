import 'package:ahorrobasic/repository/repository.dart';
import '../repository/bdconfigcoin.dart';
import 'package:sqflite/sqflite.dart';

class configcoin implements Repository<Object> {
  bdconfigcoin bdcoin = bdconfigcoin();
  //vars table
  int id_config_coin = 0;
  double monto_t = 0.0;
  double monto_ahorro = 0.0;
  double monto_init = 0.0;

  int get getidconfcoin => id_config_coin;
  double get getmontot => monto_t;
  double get getmontoah => monto_ahorro;
  double get getmontoini => monto_init;

  configcoin.fromJson(Map<String, dynamic> json) {
    id_config_coin =
        json.containsKey("id_config_coin") ? json["id_config_coin"] : 0;
    monto_t = json.containsKey("monto_t") ? json["monto_t"] : 0.0;
    monto_ahorro =
        json.containsKey("monto_ahorro") ? json["monto_ahorro"] : 0.0;
    monto_init = json.containsKey("monto_init") ? json["monto_init"] : 0.0;
  }

  Future<List<Object>> getlist(Map<String, dynamic> jsonAtri) async {
    return bdcoin.getlist(jsonAtri);
  }

  Future<int> insert(Map<String, dynamic> jsonAtri) async {
    return bdcoin.insert(jsonAtri);
  }

  Future<int> read(Map<String, dynamic> jsonAtri) async {
    return bdcoin.read(jsonAtri);
  }

  Future<int> delect(Map<String, dynamic> jsonAtri) async {
    return bdcoin.delect(jsonAtri);
  }

  Future<int> update(Map<String, dynamic> jsonAtri) async {
    return bdcoin.update(jsonAtri);
  }
}
