import 'package:flutter/material.dart';
import '../homeview/insideview.dart';
import 'analiticview.dart';

class mainanalitic extends StatelessWidget {
  mainanalitic();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: analiticview(),
    );
  }
}
