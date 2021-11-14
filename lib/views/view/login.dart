import 'package:ahorrobasic/controllador/usuario.dart';
import '../../controllador/usuarios.dart';
import '../homeview/mainhome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class loginview extends StatefulWidget {
  loginview();

  loginbody createState() => loginbody();
}

class loginbody extends State<loginview> {
  final controller = Get.put(UsuariosController());
  late User uss;
  loginbody();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(this.context).size;
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: EdgeInsets.fromLTRB(25, 45, 0, 0),
                height: 20,
                width: 110,
                decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   fit: BoxFit.fitHeight,
                    //   image: Image.asset("src/vector.png").image,
                    // ),
                    ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  width: size.width,
                  height: size.height / 3,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(25, 16, 25, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: size.width,
                          child: Text(
                            "SaCo Analitic",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: size.width,
                          child: Text(
                            "Aplicacion para poder hacer las analiticas de los gastos que tengas en tu vida  diaria, como gastos mensuales, los gastos que mas realizas, etc ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            width: size.width,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Container(
                                    margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                                    height: 20,
                                    width: 25,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image:
                                              Image.asset("src/logogoogle.png")
                                                  .image),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: Container(
                                    child: Text(
                                      "Logeate",
                                      style: TextStyle(
                                        color: Colors.grey.shade500,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onTap: () async {
                            bool comproba =
                                await UsuariosController.signInWithGoogle();

                            if (comproba) {
                              final FirebaseAuth _auth = FirebaseAuth.instance;
                              final userCredential = _auth.currentUser;
                              uss = userCredential as User;
                              print("${uss.uid}");
                              usuario us =
                                  usuario.fromJson({"code_name": uss.uid});
                              List<usuario> lisusers = await us.getlist(us, {});
                              // comprueba si el usuario existe en el sistema
                              if (lisusers.length != 0) {
                                usuario usinser = usuario.fromJson({});
                                // apaga las demas seciones activas
                                await usinser.update(usuario.fromJson({}), {});
                                // activa la ultima secion o la secion insertda
                                await usinser.update(
                                    usuario.fromJson({"code_name": uss.uid}),
                                    {});
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mainhome()),
                                );
                              } else {
                                print("${"no existe dentro del sistema"}");
                                usuario usinser = usuario.fromJson({
                                  "code_name": uss.uid,
                                  "name": uss.displayName
                                });
                                // insertar a un usuario al sistema
                                await usinser.insert(usinser, {});
                                // apaga las demas seciones activas
                                await usinser.update(usuario.fromJson({}), {});
                                // activa la ultima secion o la secion insertda
                                await usinser.update(
                                    usuario.fromJson({"code_name": uss.uid}),
                                    {});
                                print(
                                    "${"se inserto al usuario correctamente"}");
                                print("${"---------------------------------"}");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => mainhome()),
                                );
                              }
                            } else {
                              print("Parece que no se a podido logear");
                            }
                          },
                        ),
                        SizedBox(
                          height: 5,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset("src/fondologin1.png").image),
        ),
      ),
    );
  }
}
