import 'package:carros/database/database_helper.dart';
import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

import 'carro/home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 10), () {
      push(context, LoginPage(), replace: true);
    });

    //Inicializar o BD
    Future loadBanco = DatabaseHelper.getInstance().db;

    //Simulando outro carregamento
    Future outroLoad = Future.delayed(Duration(seconds: 3));

    //Usuário
    Future<Usuario> loadUsuario = Usuario.get();

    //Loads           0          1            2
    Future.wait([loadBanco, outroLoad, loadUsuario]).then((List values) {
      Usuario user = values[2];
      print(user);
      if (user != null) {
        push(context, HomePage(), replace: true);
      } else {
        push(context, LoginPage(), replace: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[200],
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
