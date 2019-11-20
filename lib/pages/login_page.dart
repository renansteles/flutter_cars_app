//nome de classe é sempre com letras minusculas e com underline no meio
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _tLogin = TextEditingController(text: "renan");

  final _tSenha = TextEditingController(text: "123");

  final _formKey = GlobalKey<FormState>();

  final _focoSenha = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    // esse método inicia antes do build
    super.initState();
  }

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
    return Form(
      //Formulario visualmente não faz nada. O key é o estado do formulario
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(16),
        // Tamanho padrão do Material Design
        child: ListView(
          children: <Widget>[
            AppText(
              "Email",
              "Digite seu email",
              controller: _tLogin,
              validatorParametro: _validacaoLogin,
              keyboardTypeParametro: TextInputType.emailAddress,
              textInputActionParametro: TextInputAction.next,
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              "Senha",
              "Digite sua senha",
              password: true,
              controller: _tSenha,
              validatorParametro: _validacaoSenha,
              keyboardTypeParametro: TextInputType.number,
              textInputActionParametro: TextInputAction.done,
              focusNodeParametro: _focoSenha,
            ),
            SizedBox(
              height: 20,
            ),
            AppButton(
              //Widget AppButton criado no arquivo app_button.dart
              "Entrar",
              onPressed: _onClickEntrar,
            ),
          ],
        ),
      ),
    );
  }

  _button(String text, Function onPressed) {
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
        onPressed:
            onPressed, //Enquanto o botão não estiver o método onPressed, ele fica desativado. Fazer teste comentando.
      ),
    );
  }

  _textForm(
    String label,
    String hint, {
    bool password = false,
    TextEditingController controller,
    FormFieldValidator<String> validatorParametro,
    TextInputType keyboardTypeParametro,
    TextInputAction textInputActionParametro,
    FocusNode focusNodeParametro,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validatorParametro,
      //Validator vindo por parametro da funcção
      keyboardType: keyboardTypeParametro,
      keyboardAppearance: Brightness.light,
      textInputAction: textInputActionParametro,
      focusNode: focusNodeParametro,
      onFieldSubmitted: (String text) {
        FocusScope.of(context)
            .requestFocus(_focoSenha); //O context vem do Statefull
      },
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
      ),
    );
  }

  _onClickEntrar() {
    bool formOk = _formKey.currentState
        .validate(); //O validate() chama o validator em todos os TextFormField
    if (!formOk) return; //validação não está ok
    String login = _tLogin.text;
    String senha = _tSenha.text;

    print("Email :$login, senha $senha");
  }

  String _validacaoLogin(String text) {
    return (text.isEmpty)
        ? "Digite o login"
        : null; //retorno nulo siginifica que está correto
  }

  String _validacaoSenha(String text) {
    if (text.isEmpty) return "Digite a senha";
    if (text.length < 3) return "Senha precisa ter pelo menos 3 caracteres";

    return null; //retorno nulo siginifica que está correto
  }
}
