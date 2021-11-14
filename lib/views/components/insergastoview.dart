import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:io';
import '../../controllador/tiponame.dart';
import '../../configinterface.dart';
import '../../controllador/deuda.dart';
//import 'package:keyboard_visibility/keyboard_visibility.dart';

// ignore: non_constant_identifier_names
tiponame tipnameobj = tiponame.fromJson({});
List<tiponame> cat = [];

// ignore: camel_case_types, must_be_immutable
class inserproductoview extends StatefulWidget {
  bool toquenedit1 = false;
  //bool toquenedit2 = false;
  ValueChanged<int> accionrecarga;
  late configinterface config;
  // memoria cache de los itens de cliente y trabajador
  // Cliente clientecacha = Cliente.fromJson({});
  // Trabajador trabajocahca = Trabajador.fromJson({});
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
  bool isChecked = false;

  inserproductoview(this.accionrecarga);
  //lista de labels
  List<String> list = [
    "Tipo de gasto: ",
    "Descripccion: ",
    "Monto: ",
    "Numero de cuotas: "
  ];
  // lista de controladores
  List<TextEditingController> listcontroler = [
    TextEditingController(text: ""), //Tipo de gasto
    TextEditingController(text: ""), //Descripccion
    TextEditingController(text: ""), //Monto
    TextEditingController(text: "") //Numero de cuotas
  ];
  List<bool> listvalide = [
    false, //Tipo de gasto
    false, //Descripccion
    false, //Monto
    false, //Numero de cuotas
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
    String imageperfil =
        "https://i.pinimg.com/564x/2e/10/c3/2e10c3d36bf257b5f9cdf04d671f1e9f.jpg";
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return config.getcolorprimary;
      }
      return config.getcolorsecundary1;
    }

    return Stack(
      children: [
        Container(
          height: config.getsizeaproxhight(350, context),
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
                              tipnameobj = tiponame.fromJson({});
                              cat = [];
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
                              "Ingresar gasto",
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
                          margin: EdgeInsets.only(left: 15),
                          child: Column(
                            children: <Widget>[
                              // contenedores de edittext
                              iteninfo(context, Icons.person,
                                  this.list[0].toString(), "", 0),
                              iteninfo(context, Icons.person,
                                  this.list[1].toString(), "", 1),
                              iteninfo(context, Icons.person,
                                  this.list[2].toString(), "", 2),
                              Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 9,
                                      child: Container(
                                        child: Text(
                                          "Si tu gasto lo has hecho por cuotas: ",
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Checkbox(
                                        checkColor: Colors.white,
                                        fillColor:
                                            MaterialStateProperty.resolveWith(
                                                getColor),
                                        value: isChecked,
                                        onChanged: (bool? value) {
                                          state(() {
                                            isChecked = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (isChecked)
                                iteninfo(context, Icons.person,
                                    this.list[3].toString(), "", 3),
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
                              "Ingresar Gasto",
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
    deuda tbj = deuda.fromJson({
      "descripccion": listcontroler[1].text,
      "monto": double.parse(
          (listcontroler[2].text == "") ? "0.0" : listcontroler[2].text),
      "id_gasto_tipo": tipnameobj.getidgastotipo,
    });
    await tbj.insert(
        tbj, {"cuotas": (isChecked) ? int.parse(listcontroler[3].text) : 0});
    //print(controller.getidusser);
    //List<Object> stado = await pedres?.insert(tbj, {}) as List<Object>;
    limpliesa();
    accionrecarga(1);
  }

  void limpliesa() {
    listcontroler[0].text = "";
    listcontroler[1].text = "";
    listcontroler[2].text = "";
    listcontroler[3].text = "";
    tipnameobj = tiponame.fromJson({});
    isChecked = false;
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
                                  child: (inx != 0)
                                      ? TextField(
                                          //focusNode: _focus[inx],
                                          keyboardType: (inx == 2)
                                              ? TextInputType.number
                                              : TextInputType.text,
                                          style: TextStyle(
                                            fontSize: config.getsizeaproxhight(
                                                15, context),
                                          ),
                                          controller: listcontroler[inx],
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Escribe un mensaje'),
                                        )
                                      : (cat.length == 0)
                                          ? FutureBuilder<List<tiponame>>(
                                              future: restiptrab!.getlist(
                                                  tiponame.fromJson({}), {}),
                                              builder: (context, snapshot) {
                                                //validadores del estado------------------------
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child:
                                                          CircularProgressIndicator());
                                                }
                                                if (snapshot.hasError) {
                                                  return Center(
                                                    child: Text(
                                                        "Error al cargar las categorias"),
                                                  );
                                                }
                                                //--------------------------------------------------
                                                var list =
                                                    snapshot.data?.length ?? 0;
                                                //###################################################
                                                int index = 0;
                                                cat = [];
                                                for (var i = 0; i < list; i++) {
                                                  var prod = snapshot.data?[i];
                                                  // inicializar el contador
                                                  if (tipnameobj.getgastotipo !=
                                                      0) {
                                                    if (tipnameobj
                                                            .getgastotipo ==
                                                        prod?.getgastotipo) {
                                                      index = i;
                                                      this.tipotrab =
                                                          prod as tiponame;
                                                    }
                                                  } else {
                                                    index = 0;
                                                    // this.tipotrab =
                                                    //     prod as TipTrabajador;
                                                  }

                                                  // -----------------------------
                                                  cat.add(tiponame.fromJson({
                                                    "id_gasto_tipo":
                                                        prod?.getidgastotipo,
                                                    "gastotipo":
                                                        prod?.getgastotipo
                                                  }));
                                                }
                                                this.tipotrab =
                                                    buildDropdownMenuItems(
                                                            cat)[0]
                                                        .value as tiponame;
                                                // print(
                                                //     "${_tipotrab.getidtrab} - ${_tipotrab.getnomtip} -> comprobante - result");
                                                return DropdownButton(
                                                  isExpanded: true,
                                                  isDense: true,
                                                  value: this.tipotrab,
                                                  items: buildDropdownMenuItems(
                                                      cat),
                                                  onChanged: (value) {
                                                    tiponame aux =
                                                        value as tiponame;
                                                    this.tipotrab = aux;
                                                    tipnameobj = aux;
                                                    state(() {});
                                                  },
                                                );
                                              },
                                            )
                                          : DropdownButton(
                                              isExpanded: true,
                                              isDense: true,
                                              value: this.tipotrab,
                                              items:
                                                  buildDropdownMenuItems(cat),
                                              onChanged: (value) {
                                                tiponame aux =
                                                    value as tiponame;
                                                this.tipotrab = aux;
                                                tipnameobj = aux;
                                                state(() {});
                                              },
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
class contentserbody extends State<inserproductoview> {
  contentserbody();

  @override
  Widget build(BuildContext context) {
    //************* Inten ***************/
    return Container();
    //***********************************************/;
  }
}
