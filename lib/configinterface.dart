import 'package:flutter/cupertino.dart';
import 'dart:io';

// se substrae un tamaño teniendo en cuenta un tamaño predeterminado
// tambien se encara de botar un color predeterminado
// ignore: camel_case_types
class configinterface {
  late BuildContext context;
  double hightstandart = 683.4285714285714;
  // lista de colores de la app
  Color colorprimary = Color(0x0ff00363a);
  Color colorsecundary = Color(0x0ff005f63);
  Color colorsecundary1 = Color(0x0ff428e92);

  configinterface(this.context);
  //contexto
  BuildContext get getcontext => this.context;
  Color get getcolorprimary => colorprimary;
  Color get getcolorsecundary => colorsecundary;
  Color get getcolorsecundary1 => colorsecundary1;

  String getsol_dolar(bool com, double canti) {
    if (!(com)) {
      canti = canti / 4.01;
      return "\$.${canti.toStringAsFixed(2)}";
    }
    return "S/.${canti.toStringAsFixed(2)}";
  }

  Future<Widget> imagepredefini(Widget imagen) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return imagen;
      }
    } on SocketException catch (_) {
      print("No presenta conexxion, Proceso online");
    }
    return Image.asset("src/img1.jpg");
  }

  double getsizeaproxhight(double tamao, BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return (size.height * (((tamao * 100) / hightstandart) / 100));
  }

  double getsizeaproxwigth(double tamao) {
    Size size = MediaQuery.of(this.context).size;
    return (size.height * (((tamao * 100) / hightstandart) / 100));
  }
}
