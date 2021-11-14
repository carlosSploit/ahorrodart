import 'package:flutter/material.dart';
import 'deudasprogramview.dart';

class maindeudasprogram extends StatelessWidget {
  maindeudasprogram();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: deudasprogramview(),
    );
  }
}
