//nome de classe é sempre com letras minusculas e com underline no meio
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16), // Tamanho padrão do Material Design
      child: ListView(
        children: <Widget>[
          Text("Email"),
          TextFormField(),
          SizedBox(
            height: 10,
          ),
          Text("Senha"),
          TextFormField(
            obscureText: true, //Mostrar ***
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            height: 46,
            child: RaisedButton(
              color: Colors.blue,
              child: Text(
                "Entrar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
              onPressed: () { //Enquanto o botão não estiver o método onPressed, ele fica desativado. Fazer teste comentando.

              },
            ),
          ),
        ],
      ),
    );
  }
}
