import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import '../../controllador/tiponame.dart';
import '../../configinterface.dart';
import '../../controllador/deuda.dart';
//import 'package:keyboard_visibility/keyboard_visibility.dart';

// ignore: non_constant_identifier_names
tiponame CategoriaMe = tiponame.fromJson({});

// ignore: camel_case_types, must_be_immutable
class insereditconfigview extends StatefulWidget {
  bool toquenedit1 = false;
  ValueChanged<double> accionrecarga;
  late configinterface config;
  BuildContext? contextgeneral;
  //---------------------------------------------------
  var state;
  deuda? pedres; // objeto que maniputas las deudas
  tiponame? restiptrab; // objeto que manipula los tipos de gastos
  int idedittext = -1;
  int idusuario = 0;
  String tipo = "";
  var controller;
  String path = "";
  BuildContext? context;

  insereditconfigview(this.accionrecarga);
  //lista de labels
  List<String> list = [
    "Escribe tu presupuesto actual: ",
  ];
  // lista de controladores
  List<TextEditingController> listcontroler = [
    TextEditingController(text: ""), //Tipo de gasto
  ];
  List<bool> listvalide = [
    false, //Tipo de gasto
  ];
  // tipo de trabajador
  tiponame tipotrab = tiponame.fromJson({});
  int idindextra = 0;
  List<tiponame> memortiRecar = [];

  //################### Action de tipo de trabajo ##################
  List<DropdownMenuItem<tiponame>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<tiponame>> items = [];
    for (tiponame company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(
            company.getgastotipo,
            style: TextStyle(),
          ),
        ),
      );
    }
    return items;
  }

  void onChangeDropdownItem(tiponame selectedCompany) {
    tipotrab = selectedCompany;
    print("${tipotrab.getidgastotipo} -> se selecciono");
    state(() {});
  }

  @override
  contentserbody createState() => contentserbody();

  createDialog(BuildContext context) {
    // this.contextgeneral = context;
    config = configinterface(context);
    this.context = context;
    var size = MediaQuery.of(context).size;
    pedres = deuda.fromJson({});
    restiptrab = tiponame.fromJson({});

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        contextgeneral = context;
        return StatefulBuilder(
          builder: (context, setState) {
            state = setState;
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              contentPadding: EdgeInsets.only(top: 10.0),
              content: contenedorDate(size, context),
            );
          },
        );
      },
    );
  }

  Widget contenedorDate(Size size, BuildContext context) {
    return Stack(
      children: [
        Container(
          height: config.getsizeaproxhight(250, context),
          //height: 400,
          width: size.width - 10,
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // Imagen de perfil del usuario
                  Stack(
                    children: [
                      Container(
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () {
                              CategoriaMe = tiponame.fromJson({});
                              limpestade();
                              limpliesa();
                              Navigator.pop(context);
                            },
                            child: Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              child: Icon(
                                Icons.arrow_back_outlined,
                                size: config.getsizeaproxhight(30, context),
                                color: Colors.grey.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 30, top: 20),
                            child: Text(
                              "Editar presupuesto actual",
                              style: TextStyle(
                                color: config.getcolorprimary,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  // ---------------------------------------------
                  Expanded(
                      child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(15, 0, 25, 0),
                        color: Colors.white,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              iteninfo(context, Icons.person,
                                  this.list[0].toString(), "", 0),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                  Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          insertartrabajador();
                        },
                        child: Container(
                          height: config.getsizeaproxhight(50, context),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Editar Gasto",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: config.getcolorprimary,
                            //color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ],
    );
  }

  void insertartrabajador() async {
    //print(controller.getidusser);
    //List<Object> stado = await pedres?.insert(tbj, {}) as List<Object>;
    accionrecarga(double.parse(
        (listcontroler[0].text == "") ? "0.0" : listcontroler[0].text));
    limpliesa();
  }

  void limpliesa() {
    listcontroler[0].text = "";
  }

  void limpestade() {
    for (var i = 0; i < listvalide.length; i++) {
      listvalide[i] = false;
    }
  }

  void validar(List<bool> list) {
    for (var i = 0; i < list.length; i++) {
      listvalide[i] = list[i];
    }
  }

  Widget iteninfo(
      BuildContext context, IconData icon, String label, var info, int inx) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
              //color: Colors.black,
              child: Align(
                alignment: Alignment.center,
                child: Icon(
                  icon,
                  size: config.getsizeaproxhight(24, context),
                  color: Colors.grey.withOpacity(0.8),
                ),
              ),
            ),
            flex: 1,
          ),
          Expanded(
            child: Container(
              height: config.getsizeaproxhight(60, context),
              //color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(5, 0, 0, 5),
                      child: Text(
                        "$label",
                        style: TextStyle(
                            fontSize: config.getsizeaproxhight(14, context),
                            color: Colors.grey[800],
                            fontWeight: FontWeight.w700),
                      )),
                  Container(
                    child: Expanded(
                      child: Container(
                        child: Container(
                          height: config.getsizeaproxhight(40, context),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontSize:
                                          config.getsizeaproxhight(15, context),
                                    ),
                                    controller: listcontroler[inx],
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Escribe el monto'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: Colors.white,
                            border: Border.all(
                              color: (listvalide[inx])
                                  ? Colors.red
                                  : Color(0xff707070).withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                      flex: 8,
                    ),
                  ),
                ],
              ),
            ),
            flex: 6,
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class contentserbody extends State<insereditconfigview> {
  contentserbody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    return Container();
    //***********************************************/;
  }
}
