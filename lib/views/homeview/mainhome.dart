import 'package:flutter/material.dart';
import 'insideview.dart';

class mainhome extends StatelessWidget {
  mainhome();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: insideview(),
    );
  }
}
