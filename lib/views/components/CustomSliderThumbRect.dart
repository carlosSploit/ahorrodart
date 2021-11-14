import 'package:ahorrobasic/configinterface.dart';
import 'package:ahorrobasic/controllador/configcoin.dart';
import 'package:ahorrobasic/controllador/deuda.dart';
import 'package:ahorrobasic/views/components/CustomSliderThumbRect.dart';
import 'package:flutter/material.dart';

class sliderbarview extends StatefulWidget {
  sliderbarview(this.confcoin, this.dolar_pen, this.actualizar);
  final String title = "Aplications";
  configcoin confcoin;
  bool dolar_pen;
  ValueChanged<double> actualizar;

  @override
  sliderbarbody createState() => sliderbarbody();
}

class sliderbarbody extends State<sliderbarview> {
  int counter = 0;
  double valueprogres = 1.0;
  late configinterface config = configinterface(
      context); // redimenciona la interface teniendo en cuenta una interface predeterminada

  @override
  Widget build(BuildContext context) {
    valueprogres = widget.confcoin.getmontoah;
    return SliderTheme(
        data: SliderTheme.of(context).copyWith(
            thumbShape: SliderComponentShape.noThumb,
            activeTickMarkColor: Colors.transparent,
            inactiveTickMarkColor: Colors.transparent,
            trackHeight: 25.0),
        child: Container(
          height: 40,
          child: Stack(
            children: [
              Slider(
                label: "${config.getsol_dolar(widget.dolar_pen, valueprogres)}",
                thumbColor: Color(0xff707070),
                value: valueprogres * 1.0,
                min: 0,
                max: widget.confcoin.getmontoini,
                activeColor: config.getcolorprimary,
                inactiveColor: config.getcolorsecundary1,
                onChanged: (double value) async {
                  if (value < widget.confcoin.getmontot) {
                    valueprogres = value;
                  }
                  setState(() {});
                },
                onChangeEnd: (double value) async {
                  widget.actualizar(value);
                },
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: Center(
                    child: Text(
                      "${config.getsol_dolar(widget.dolar_pen, valueprogres)}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
