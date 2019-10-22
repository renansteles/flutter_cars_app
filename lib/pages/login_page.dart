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
          _textForm("Email", "Digite seu email"),
          SizedBox(
            height: 10,
          ),
          _textForm("Senha", "Digite sua senha", password: true),
          SizedBox(
            height: 20,
          ),
          _button("Entrar"),
        ],
      ),
    );
  }

  Container _button(String text) {
    return Container(
      height: 46,
      child: RaisedButton(
        color: Colors.blue,
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          //Enquanto o botão não estiver o método onPressed, ele fica desativado. Fazer teste comentando.
        },
      ),
    );
  }

  //O que está entre {} é um NamedArgument. Não é obrigatório utilizá-lo quando chamar o método, porem se tiver o @required, fica obrigatório.
  _textForm(String label, String hint, {bool password = false}) {
    return TextFormField(
      obscureText: password,
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
      ),
    );
  }
}
