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
          TextFormField(
            style: TextStyle(color: Colors.blue),
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(color: Colors.lightBlue[100]),
              hintText: "Digite seu email",
              hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            obscureText: true, //Mostrar ***
            decoration: InputDecoration(
                labelText: "Senha", hintText: "Digite sua senha"),
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
              onPressed: () {
                //Enquanto o botão não estiver o método onPressed, ele fica desativado. Fazer teste comentando.
              },
            ),
          ),
        ],
      ),
    );
  }
}
