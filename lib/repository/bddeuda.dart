import 'package:ahorrobasic/controllador/usuario.dart';
import 'package:ahorrobasic/repository/repository.dart';
import 'package:sqflite/sqflite.dart';
import '../controllador/deuda.dart';
import 'bdconexion.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jiffy/src/enums/units.dart';

class bddeuda implements Repository<deuda> {
  Future<List<deuda>> getlist(deuda deud, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    //-----------------------------------------
    usuario uax = usuario.fromJson({});
    int idusuario = await uax.userconnet();
    //-----------------------------------------
    print(
        "${jsonAtri.containsKey('cuotas') ? jsonAtri['cuotas'] : "es nullo we"}");
    final List<Map<String, dynamic>> Datosusermap = await database.rawQuery(
        '''SELECT d.id_deuda, d.monto, d.descripccion, d.fecha, t.gastotipo, d.id_gasto_tipo
          FROM deuda d, tipogasto t
          WHERE strftime('%m', ${jsonAtri.containsKey('month') ? "d.fecha" : "'now'"}) = ${jsonAtri.containsKey('month') ? "'" + jsonAtri['month'] + "'" : "strftime('%m', d.fecha)"}
          AND strftime('%Y', ${jsonAtri.containsKey('year') ? "d.fecha" : "'now'"}) = ${jsonAtri.containsKey('year') ? "'" + jsonAtri['year'] + "'" : "strftime('%Y', d.fecha)"}
          AND d.id_gasto_tipo = t.id_gasto_tipo
          ${(jsonAtri.containsKey('month') && jsonAtri.containsKey('year')) ? "AND d.id_depent_deuda <> 0" : ""}
          AND d.id_usuario  = ${idusuario} ''' +
            ((jsonAtri['idgatotipo'] == 0 || (jsonAtri['idgatotipo'] == null))
                ? ""
                : '''AND d.id_gasto_tipo like ${jsonAtri['idgatotipo']}''') +
            ((jsonAtri['cuotas'] == 0)
                ? ""
                : ''' ORDER BY d.id_deuda DESC LIMIT 1 ''') +
            ''' ; ''');
    //---------------------------------------------------
    print("print bd deuda - ${Datosusermap.length}");
    print(Datosusermap);
    //---------------------------------------------------
    // generar la lista
    return List.generate(
      Datosusermap.length,
      (index) => deuda.fromJson({
        "id_deuda": Datosusermap[index]['id_deuda'],
        "id_gasto_tipo": Datosusermap[index]['id_gasto_tipo'],
        "descripccion": Datosusermap[index]['descripccion'],
        "monto": Datosusermap[index]['monto'],
        "fecha": Datosusermap[index]['fecha'],
        "gastotipo": Datosusermap[index]['gastotipo'],
      }),
    );
  }

  // Extrae las deudas programadas en un mes
  Future<List<fechacdeuda>> listfechadeuda(
      deuda deud, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    //-----------------------------------------
    usuario uax = usuario.fromJson({});
    int idusuario = await uax.userconnet();
    //-----------------------------------------
    final List<Map<String, dynamic>> Datosusermap = await database.rawQuery(
        '''SELECT strftime('%Y',d.fecha) as year , strftime('%m',d.fecha) as mont, sum(d.monto) as monto_tot 
        FROM deuda d 
        WHERE d.id_depent_deuda <> 0 
        AND d.id_usuario = ${idusuario}
        GROUP BY year, mont ; ''');
    //---------------------------------------------------
    print("print bd deuda - ${Datosusermap.length}");
    print(Datosusermap);
    //---------------------------------------------------
    // generar la lista
    return List.generate(
      Datosusermap.length,
      (index) => fechacdeuda.fromJson({
        "year": Datosusermap[index]['year'],
        "mont": Datosusermap[index]['mont'],
        "monto_tot": Datosusermap[index]['monto_tot']
      }),
    );
  }

  // calcula el monto total gastado tenindo en cuenta la fecha actual
  Future<double> montototalgasto(
      deuda deud, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    //-----------------------------------------
    usuario uax = usuario.fromJson({});
    int idusuario = await uax.userconnet();
    //-----------------------------------------
    final List<Map<String, dynamic>> Datosusermap =
        await database.rawQuery('''SELECT sum(d.monto)
                  FROM deuda d, tipogasto t
                  WHERE strftime('%m','now') = strftime('%m', d.fecha) 
                  AND strftime('%Y','now') = strftime('%Y', d.fecha)
                  AND d.id_gasto_tipo = t.id_gasto_tipo
                  AND id_usuario  = ${idusuario};''');
    //---------------------------------------------------
    print("print bd deuda - ${Datosusermap.length}");
    print(Datosusermap);
    //---------------------------------------------------
    // generar la lista
    if (Datosusermap.length != 0 && Datosusermap[0]['sum(d.monto)'] != null) {
      return Datosusermap[0]['sum(d.monto)'] * 1.0;
    }
    return -1;
  }

  Future<int> insert(deuda deud, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    //-----------------------------------------
    usuario uax = usuario.fromJson({});
    int idusuario = await uax.userconnet();
    //-----------------------------------------
    await database.rawInsert(
        "INSERT INTO deuda ( monto , descripccion , fecha , id_gasto_tipo , id_depent_deuda , id_usuario ) VALUES ( ${deud.getmonto} , '${deud.getdescripccion}' , '${DateTime.now().year}-${bd.convertuncaddoscar(DateTime.now().month)}-${bd.convertuncaddoscar(DateTime.now().day)}' , ${deud.gettipname.getidgastotipo} , 0 , ${idusuario} ) ;");
    DateTime fecha = Jiffy(DateTime.now()).add(months: 1).dateTime;
    print(
        "${fecha.year}-${bd.convertuncaddoscar(fecha.month)}-${bd.convertuncaddoscar(fecha.day)}");
    // en caso que este caso
    if (jsonAtri['cuotas'] != 0) {
      List<deuda> listaux = await getlist(deuda.fromJson({}), {
        'cuotas': (jsonAtri['cuotas'] != 0) ? (jsonAtri['cuotas'] as int) : 0
      });
      for (var i = 1; i <= (jsonAtri['cuotas'] as int); i++) {
        DateTime fecha = Jiffy(DateTime.now()).add(months: i).dateTime;
        await database.rawInsert(
            "INSERT INTO deuda ( monto , descripccion , fecha , id_gasto_tipo , id_depent_deuda , id_usuario ) VALUES ( ${deud.getmonto} , '${deud.getdescripccion}' , '${fecha.year}-${bd.convertuncaddoscar(fecha.month)}-${bd.convertuncaddoscar(fecha.day)}' , ${deud.gettipname.getidgastotipo} , ${listaux[0].getiddeuda} , ${idusuario} ) ;");
      }
      // comprobar si en realidad se inserto las cuotas en el sistema
      final List<Map<String, dynamic>> Datosusermap = await database.rawQuery(
          '''SELECT * FROM deuda d WHERE d.id_depent_deuda <> 0 AND d.id_usuario = ${idusuario} ; ''');
      //---------------------------------------------------
      print("print bd insertar cuotas - ${Datosusermap.length}");
      print(Datosusermap);
      //---------------------------------------------------
    }
    return 0;
  }

  // realiza el analisis realido en cada categoria
  Future<List<Analiticgasto>> analiticPorcenGastoCategori(
      deuda deud, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    //-----------------------------------------
    usuario uax = usuario.fromJson({});
    int idusuario = await uax.userconnet();
    //-----------------------------------------
    final List<Map<String, dynamic>> Datosusermap = await database
        .rawQuery('''SELECT (sum(d.monto)*100)/(SELECT sum(d.monto)
                    FROM deuda d, tipogasto t
                    WHERE strftime('%m','now') = strftime('%m', d.fecha) 
                    AND strftime('%Y','now') = strftime('%Y', d.fecha)
                    AND d.id_gasto_tipo = t.id_gasto_tipo
                    AND id_usuario  = ${idusuario}) as porcentaje , t.gastotipo, d.id_gasto_tipo
                    FROM deuda d, tipogasto t
                    WHERE strftime('%m','now') = strftime('%m', d.fecha) 
                    AND strftime('%Y','now') = strftime('%Y', d.fecha)
                    AND d.id_gasto_tipo = t.id_gasto_tipo
                    AND id_usuario  = ${idusuario}
                    GROUP by d.id_gasto_tipo;''');
    //---------------------------------------------------
    print("print bd analiticPorcenGastoCategori - ${Datosusermap.length}");
    print(Datosusermap);
    //---------------------------------------------------
    // generar la lista
    return List.generate(
      Datosusermap.length,
      (index) => Analiticgasto.fromJson({
        "id_gasto_tipo": Datosusermap[index]['id_gasto_tipo'],
        "porcentaje": Datosusermap[index]['porcentaje'],
        "gastotipo": Datosusermap[index]['gastotipo'],
      }),
    );
  }

  Future<List<Analiticgasto>> analiticGastoMensual(
      deuda deud, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    //-----------------------------------------
    usuario uax = usuario.fromJson({});
    int idusuario = await uax.userconnet();
    //-----------------------------------------
    final List<Map<String, dynamic>> Datosusermap = await database.rawQuery(
        '''SELECT sum(monto) as monto , strftime('%Y',fecha) || strftime('%m',fecha) as fecha_anal
                     FROM deuda
                     WHERE id_usuario = ${idusuario}
                     AND (CAST(strftime('%Y',fecha) AS INTEGER) - CAST(strftime('%Y','now') AS INTEGER)) >= 0
                     AND (CAST(strftime('%Y',fecha) AS INTEGER) - CAST(strftime('%Y','now') AS INTEGER)) <= 1
                     GROUP by fecha_anal LIMIT 5;''');
    //---------------------------------------------------
    print("print bd analiticGastoMensual - ${Datosusermap.length}");
    print(Datosusermap);
    //---------------------------------------------------
    // generar la lista
    return List.generate(
      Datosusermap.length,
      (index) => Analiticgasto.fromJson({
        "monto": Datosusermap[index]['monto'],
        "fecha_anal": Datosusermap[index]['fecha_anal'],
      }),
    );
  }

  Future<deuda> read(deuda deud, Map<String, dynamic> jsonAtri) async {
    deuda deu = deuda.fromJson({});
    Database database = await bd.openDB();
    return deu;
  }

  Future<int> delect(deuda deud, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    await database
        .rawDelete("DELETE FROM deuda WHERE id_deuda = ${deud.getiddeuda} ;");
    return 0;
  }

  Future<int> update(deuda deud, Map<String, dynamic> jsonAtri) async {
    Database database = await bd.openDB();
    return 0;
  }
}
