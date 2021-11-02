import 'package:ahorrobasic/repository/repository.dart';
import '../repository/bdconfigcoin.dart';
import 'package:sqflite/sqflite.dart';

class configcoin implements Repository<Object> {
  bdconfigcoin bdcoin = bdconfigcoin();

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
