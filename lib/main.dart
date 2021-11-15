import 'package:ahorrobasic/controllador/usuario.dart';
import 'package:ahorrobasic/views/homeview/insideview.dart';
import 'package:flutter/material.dart';
import 'views/view/login.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    usuario us = usuario.fromJson({});
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder<List<usuario>>(
        future: us.getlist(usuario.fromJson({}), {}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  "src/iconapli.png",
                  height: 60,
                  width: 60,
                ),
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
          var auxconfi = snapshot.data as List<usuario>;
          if (auxconfi.length == 0) {
            return loginview();
          } else {
            return insideview();
          }
        },
      ),
    );
  }
}
