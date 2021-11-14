import 'package:ahorrobasic/configinterface.dart';
import 'package:ahorrobasic/controllador/deuda.dart';
import 'package:ahorrobasic/controllador/tiponame.dart';
import 'package:ahorrobasic/main.dart';
import 'package:ahorrobasic/views/components/CustomSliderThumbRect.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../controllador/configcoin.dart';
import '../../controllador/deuda.dart';
import '../components/insergastoview.dart';
import 'package:getwidget/getwidget.dart';

class deudasprogramview extends StatefulWidget {
  deudasprogramview();
  final String title = "Deudas Programadas";
  int _selexidcateg = 0;
  List<Item> listitem = [];

  @override
  deudasprogrambody createState() => deudasprogrambody();
}

class deudasprogrambody extends State<deudasprogramview> {
  int counter = 0;
  double valueprogres = 1.0;
  double gasto = 400.0; // los gastos en general
  bool dolar_pen = true; // si es true la moneda es normal, sino es dolar
  late configinterface config = configinterface(
      context); // redimenciona la interface teniendo en cuenta una interface predeterminada
  configcoin confcoin = configcoin.fromJson({
    "id_config_coin": 10,
    "monto_t": 990.0,
    "monto_ahorrado": 10.0,
    "monto_init": 0,
  });
  tiponame tip = tiponame.fromJson({});
  deuda deu = deuda.fromJson({});
  late TooltipBehavior _tooltipBehavior = TooltipBehavior(enable: true);
  List<Analiticgasto> listana = [
    Analiticgasto.fromJson(
        {"porcentaje": 10, "gastotipo": "Compras a credito"}),
    Analiticgasto.fromJson(
        {"porcentaje": 50, "gastotipo": "Compras de contado"}),
    Analiticgasto.fromJson(
        {"porcentaje": 60, "gastotipo": "Pagos de servicios"}),
    Analiticgasto.fromJson({"porcentaje": 30, "gastotipo": "Pagos de tarjetas"})
  ];

  List<deuda> listdeuda = [
    deuda.fromJson({
      "id_deuda": 10,
      "id_gasto_tipo": 1,
      "gastotipo": "Compras a credito",
      "monto": 60,
      "fecha": "2021-11-05",
      "descripccion": "Compre un par de sapatillas con mi tarjeta interbanck",
    }),
    deuda.fromJson({
      "id_deuda": 11,
      "id_gasto_tipo": 2,
      "gastotipo": "Compras de contado",
      "monto": 60,
      "fecha": "2021-11-05",
      "descripccion": "Comprar una bolsa de pan",
    }),
    deuda.fromJson({
      "id_deuda": 12,
      "id_gasto_tipo": 3,
      "gastotipo": "Pagos de servicios",
      "monto": 60,
      "fecha": "2021-11-05",
      "descripccion": "Pago de la luz",
    }),
    deuda.fromJson({
      "id_deuda": 14,
      "id_gasto_tipo": 4,
      "gastotipo": "Pagos de tarjetas",
      "monto": 60,
      "fecha": "2021-11-05",
      "descripccion": "Pago de los servicios de pan etc",
    }),
  ];
  List<IconData> lisdaticon = [
    Icons.shopping_bag,
    Icons.shopping_bag,
    Icons.account_balance_wallet,
    Icons.account_balance_wallet
  ];
  List<recomend> listrecome = [
    recomend.fromJson({
      "idrecomen": 1,
      "recoment": "Fija un monto de ahorro mensual.",
    }),
    recomend.fromJson({
      "idrecomen": 2,
      "recoment": "Planea tus compras de víveres antes de ir al mercado.",
    }),
    recomend.fromJson({
      "idrecomen": 3,
      "recoment": "Prepara un fondo de emergencias.",
    }),
    recomend
        .fromJson({"idrecomen": 4, "recoment": "No uses la tarjeta de crédito"})
  ];
  List<Color> listcolor = [
    Colors.green.shade400,
    Colors.red.shade400,
    Colors.blue.shade400,
    Colors.yellow.shade400
  ];

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    listcolor = [
      config.getcolorprimary,
      config.getcolorsecundary,
      config.getcolorsecundary1,
      Colors.yellow.shade400
    ];
    valueprogres = confcoin.getmontoah;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(
          child:
              Icon(Icons.arrow_back_ios_new, color: config.getcolorsecundary),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyApp()),
            );
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.grey.shade600),
        ),
        actions: <Widget>[],
      ),
      body: Center(
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            // Recomendaciones del ahorro
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  titulo("Recomendaciones de ahorro"),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FutureBuilder<List<fechacdeuda>>(
                          future: deu.listfechadeuda(deuda.fromJson({}), {}),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: 10, right: 10, bottom: 10),
                              );
                            }
                            if (snapshot.hasError) {
                              return Center(
                                child: Text("Error al cargar las categorias"),
                              );
                            }
                            //------------------------------------------------
                            //capturar las categorias
                            var auxconfi = snapshot.data as List<fechacdeuda>;
                            widget.listitem = List.generate(
                                auxconfi.length,
                                (index) => Item(
                                    "${auxconfi[index].getfecha}/${auxconfi[index].getmonth}",
                                    "${auxconfi[index].getfecha} / ${auxconfi[index].getmonth} monto : ${auxconfi[index].getmonto}",
                                    false));
                            for (fechacdeuda item in auxconfi) {
                              print("${item.getfecha + "-" + item.getmonth}");
                            }
                            return Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: widget.listitem.map((e) {
                                  return GFAccordion(
                                      margin: EdgeInsets.only(bottom: 5),
                                      contentChild: FutureBuilder<List<deuda>>(
                                        future:
                                            deu.getlist(deuda.fromJson({}), {
                                          "idgatotipo": 0,
                                          "cuotas": 0,
                                          "month": e.getexpanded.split("/")[1],
                                          "year": e.getexpanded.split("/")[0],
                                        }),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return Container(
                                              margin: EdgeInsets.only(
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                              child: Column(
                                                children: listdeuda.map((e) {
                                                  return carddeudas(
                                                      lisdaticon[e.gettipname
                                                              .getidgastotipo -
                                                          1],
                                                      e.getiddeuda,
                                                      e.gettipname.getgastotipo,
                                                      e.getdescripccion,
                                                      e.getfecha,
                                                      e.getmonto);
                                                }).toList(),
                                              ),
                                            );
                                          }
                                          if (snapshot.hasError) {
                                            return Center(
                                              child: Text(
                                                  "Error al cargar las categorias"),
                                            );
                                          }
                                          //------------------------------------------------
                                          //capturar las categorias
                                          var auxconfi =
                                              snapshot.data as List<deuda>;
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            child: Column(
                                              children: auxconfi.map((e) {
                                                return carddeudas(
                                                    lisdaticon[e.gettipname
                                                            .getidgastotipo -
                                                        1],
                                                    e.getiddeuda,
                                                    e.gettipname.getgastotipo,
                                                    e.getdescripccion,
                                                    e.getfecha,
                                                    e.getmonto);
                                              }).toList(),
                                            ),
                                          );
                                        },
                                      ),
                                      title: e.gettitle);
                                }).toList());
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          inserproductoview(actualizar).createDialog(this.context);
        },
        backgroundColor: config.getcolorprimary,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  // cart de cada categoria, el cual actualizara el estado
  Widget buildChip(int idexcat, String label, Color color) {
    return InkWell(
      onTap: () {
        widget._selexidcateg = idexcat;
        setState(() {});
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
        child: Chip(
          labelPadding: EdgeInsets.all(2.0),
          avatar: CircleAvatar(
            backgroundColor:
                (widget._selexidcateg == idexcat) ? Colors.white : color,
            child: Text(
              label[0].toUpperCase(),
              style: TextStyle(
                  fontSize: config.getsizeaproxhight(15, context),
                  color:
                      (widget._selexidcateg == idexcat) ? color : Colors.white),
            ),
          ),
          label: Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: config.getsizeaproxhight(15, context),
                color: (widget._selexidcateg == idexcat) ? Colors.white : color,
              ),
            ),
          ),
          backgroundColor:
              (widget._selexidcateg == idexcat) ? color : Colors.white,
          elevation: 6.0,
          shadowColor: Colors.grey[60],
          padding: EdgeInsets.all(8.0),
        ),
      ),
    );
  }

  void actualizar(int a) {
    setState(() {});
  }

  void actualizarconfig(double a) async {
    confcoin.setmontoini = a;
    confcoin.setmontot = confcoin.getmontoini - confcoin.getmontoah;
    await confcoin.update(confcoin, {});
    setState(() {});
  }

  Widget botondolarpen() {
    return InkWell(
      onTap: () {
        dolar_pen = !(dolar_pen);
        setState(() {});
      },
      child: Container(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 5),
          height: config.getsizeaproxhight(30, context),
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "PEN",
                      style: TextStyle(
                        color:
                            (dolar_pen) ? config.getcolorprimary : Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: (dolar_pen) ? Colors.white : config.getcolorprimary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      "DOL",
                      style: TextStyle(
                        color:
                            (dolar_pen) ? Colors.white : config.getcolorprimary,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: (dolar_pen) ? config.getcolorprimary : Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: config.getcolorprimary,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Widget estado_gastos_mes(List<Analiticgasto> listana) {
    counter = 0;
    return Container(
      height: config.getsizeaproxhight(180, context),
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: SfCircularChart(
                  palette: listcolor,
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    DoughnutSeries<Analiticgasto, String>(
                      dataSource: listana,
                      xValueMapper: (Analiticgasto data, _) =>
                          (data.getname.toString() +
                              "\n${data.getporcent.toString()}% "),
                      yValueMapper: (Analiticgasto data, _) => data.getporcent,
                      cornerStyle: CornerStyle.bothFlat,
                      strokeWidth: 12.0,
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: listana.map((e) {
                    Widget label = labelint(
                        e.getname.getgastotipo + "\n${e.getporcent}%",
                        listcolor[counter]);
                    counter++;
                    return label;
                  }).toList(),
                ),
              ),
            )
          ],
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }

  Widget carddeudas(IconData icon, int id, String nombre, String descrip,
      String fecha, double monto) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  child: Center(
                    child: Icon(icon,
                        size: config.getsizeaproxhight(40, context),
                        color: config.getcolorsecundary),
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "$nombre",
                          style: TextStyle(
                              fontSize: config.getsizeaproxhight(18, context),
                              color: config.getcolorprimary,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: config.getsizeaproxhight(10, context),
                      ),
                      Container(
                        child: Text(
                          "$descrip",
                          overflow: TextOverflow.clip,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          "$fecha",
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ),
                      SizedBox(
                        height: config.getsizeaproxhight(10, context),
                      ),
                      Container(
                        child: Text(
                          "- ${config.getsol_dolar(this.dolar_pen, monto)}",
                          style: TextStyle(
                            fontSize: config.getsizeaproxhight(18, context),
                            color: Colors.red,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  alignment: Alignment.topCenter,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: InkWell(
                      onTap: () async {
                        await deu.delect(deuda.fromJson({"id_deuda": id}), {});
                        setState(() {});
                      },
                      child: Icon(
                        Icons.close,
                        size: config.getsizeaproxhight(20, context),
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: config.getsizeaproxhight(15, context),
          ),
          Container(
            height: config.getsizeaproxhight(1.5, context),
            color: Colors.grey.withOpacity(0.2),
          ),
        ],
      ),
    );
  }

  Widget estado_billetera_mes(configcoin confcoin) {
    deu.montototalgasto(deuda.fromJson({}), {}).then((value) => this.gasto);
    return cardredond(
      padding: EdgeInsets.all(15),
      title: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Center(
                      child: FutureBuilder<double>(
                        future: deu.montototalgasto(deuda.fromJson({}), {}),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            double resul =
                                (((0 * 100) / confcoin.getmontot) / 100);
                            return CircularPercentIndicator(
                              radius: config.getsizeaproxhight(100.0, context),
                              lineWidth:
                                  config.getsizeaproxhight(11.0, context),
                              backgroundColor: config.getcolorsecundary1,
                              percent:
                                  (resul < 0) ? 0 : resul, //porcentaje de uso
                              progressColor: ((confcoin.getmontot * 0.7) < 0)
                                  ? Colors.red
                                  : config.getcolorprimary,
                              circularStrokeCap: CircularStrokeCap.round,
                              animation: true,
                              center: Text(
                                "${((0 * 100) / confcoin.getmontot).toStringAsFixed(2)}%",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.grey.shade400),
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error al cargar las categorias"),
                            );
                          }
                          //------------------------------------------------
                          //capturar las categorias
                          var auxconfi = snapshot.data as double;
                          double resul =
                              ((auxconfi * 100) / confcoin.getmontot) / 100;
                          double porcel =
                              ((auxconfi * 100) / confcoin.getmontot);
                          return CircularPercentIndicator(
                            radius: config.getsizeaproxhight(100.0, context),
                            lineWidth: config.getsizeaproxhight(11.0, context),
                            backgroundColor: config.colorsecundary1,
                            percent:
                                (resul < 0) ? 0 : resul, //porcentaje de uso
                            progressColor:
                                ((confcoin.getmontot * 0.7) < auxconfi)
                                    ? Colors.red
                                    : config.getcolorprimary,
                            circularStrokeCap: CircularStrokeCap.round,
                            animation: true,
                            center: Text(
                              "${((porcel < 0) ? 0.0 : porcel).toStringAsFixed(2)}%",
                              style: TextStyle(
                                fontSize: 20,
                                color: ((confcoin.getmontot * 0.7) < auxconfi)
                                    ? Colors.red
                                    : config.getcolorprimary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "Presupuesto",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "${config.getsol_dolar(this.dolar_pen, (confcoin.getmontot == -1) ? 0 : confcoin.getmontot)}",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: config.getsizeaproxhight(10, context),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Text(
                                  "Gasto",
                                  style: TextStyle(
                                    fontSize:
                                        config.getsizeaproxhight(16, context),
                                    color: ((confcoin.getmontot * 0.7) < gasto)
                                        ? Colors.red
                                        : Colors.grey.shade700,
                                  ),
                                ),
                              ),
                              FutureBuilder<double>(
                                future:
                                    deu.montototalgasto(deuda.fromJson({}), {}),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Container(
                                      child: Text(
                                        "S/.00",
                                        style: TextStyle(
                                          fontSize: config.getsizeaproxhight(
                                              20, context),
                                          color: ((confcoin.getmontot * 0.7) <
                                                  gasto)
                                              ? Colors.red
                                              : Colors.grey.shade700,
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(
                                          "Error al cargar las categorias"),
                                    );
                                  }
                                  //------------------------------------------------
                                  //capturar las categorias
                                  var auxconfi = snapshot.data as double;
                                  return Container(
                                    child: Text(
                                      "${config.getsol_dolar(this.dolar_pen, (auxconfi == -1) ? 0 : auxconfi)}",
                                      style: TextStyle(
                                        fontSize: config.getsizeaproxhight(
                                            20, context),
                                        color:
                                            ((confcoin.getmontot * 0.7) < gasto)
                                                ? Colors.red
                                                : Colors.grey.shade700,
                                      ),
                                    ),
                                  );
                                },
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget Ahorro_tu_dinero_mensual(configcoin confcoin) {
    return cardredond(
      padding: EdgeInsets.all(15),
      title: Container(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Presupuesto",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        Container(
                          child: Text(
                            "${config.getsol_dolar(this.dolar_pen, confcoin.getmontoini)}",
                            style: TextStyle(
                                fontSize:
                                    config.getsizeaproxhight(20, context)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          "Presu. Ahorro",
                          style: TextStyle(
                              fontSize: config.getsizeaproxhight(16, context)),
                        ),
                      ),
                      Container(
                        child: Text(
                          "${config.getsol_dolar(this.dolar_pen, confcoin.getmontot)}",
                          style: TextStyle(
                              fontSize: config.getsizeaproxhight(20, context)),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: config.getsizeaproxhight(10, context),
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Center(
                        child: Icon(Icons.account_balance_wallet_outlined,
                            color: config.getcolorprimary,
                            size: config.getsizeaproxhight(50, context)),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      child: Center(
                          child: sliderbarview(
                              confcoin, dolar_pen, acualizarestadoahorro)),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Center(
                        child: Icon(Icons.savings_outlined,
                            color: config.getcolorsecundary1,
                            size: config.getsizeaproxhight(50, context)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void acualizarestadoahorro(double value) async {
    if (value < confcoin.getmontot) {
      valueprogres = value;
      confcoin.setmontoah = valueprogres;
      confcoin.setmontot = confcoin.getmontoini - confcoin.getmontoah;
      print("termino");
      await confcoin.update(confcoin, {});
      List<configcoin> aux =
          await confcoin.getlist(configcoin.fromJson({}), {"tipo": 0});
      configcoin coinconffinal =
          await confcoin.read(configcoin.fromJson({"id_config_coin": 1}), {});
      print("${coinconffinal.getmontoah} - ahorrado");
      print("${aux.length} - id ultimo");
    }
    setState(() {});
  }

  Widget cardrecomend(int index, String recomend) {
    return Container(
      height: config.getsizeaproxhight(160, context),
      margin: EdgeInsets.only(right: 15),
      padding: EdgeInsets.only(right: 5),
      width: 120,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(
                  top: 10,
                  left: 10,
                ),
                width: 20,
                height: config.getsizeaproxhight(50, context),
                child: Center(
                    child: Text(
                  "$index",
                  style: TextStyle(
                      fontSize: config.getsizeaproxhight(16, context),
                      fontWeight: FontWeight.w800,
                      color: config.getcolorprimary),
                )),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "$recomend",
                  overflow: TextOverflow.fade,
                  maxLines: 6,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
      decoration: BoxDecoration(
        color: config.getcolorprimary,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }

  // label del grafico
  Widget labelint(String label, Color colors) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: Container(
                height: config.getsizeaproxhight(15, context),
                width: 15,
                decoration:
                    BoxDecoration(color: colors, shape: BoxShape.circle),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: Text("$label"),
            ),
          )
        ],
      ),
    );
  }

  // title
  Widget titulo(String title) {
    Size size = MediaQuery.of(this.context).size;
    return Container(
      width: size.width - 15,
      padding: EdgeInsets.all(15),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "$title",
          style: TextStyle(
            fontSize: config.getsizeaproxhight(20, context),
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  // title
  Widget cardredond({required Widget title, required EdgeInsets padding}) {
    Size size = MediaQuery.of(this.context).size;
    return Container(
      width: size.width - 30,
      margin: EdgeInsets.only(left: 15, right: 15),
      padding: padding,
      child: Align(
        alignment: Alignment.center,
        child: Expanded(
          flex: 1,
          child: title,
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}

class Item {
  String expanded = "";
  String title = "";
  bool isExpanded = false;

  String get getexpanded => expanded;
  String get gettitle => title;
  bool get getisExpanded => isExpanded;

  Item(this.expanded, this.title, this.isExpanded);
}

class recomend {
  int idrecomen = 0;
  String recoment = "desconocido";

  int get getidrecomen => idrecomen;
  String get getrecoment => recoment;

  recomend.fromJson(Map<String, dynamic> json) {
    idrecomen = json.containsKey("idrecomen") ? json["idrecomen"] : 0;
    recoment = json.containsKey("recoment") ? json["recoment"] : "desconocido";
  }
}
