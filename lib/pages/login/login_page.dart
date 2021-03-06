//nome de classe é sempre com letras minusculas e com underline no meio
import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/carro/home_page.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/login_bloc.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/alert.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/widgets/app_button.dart';
import 'package:carros/widgets/app_text.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //user ou admin senha 123
  final _tLogin = TextEditingController();

  final _bloc = LoginBloc();

  final _tSenha = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final _focoSenha = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    // esse método inicia antes do build
    super.initState();

    //Código foi para a Splash Page
//    Usuario.get().then((user) {
//      if (user != null) {
//        //Login automarico. Usuario salvo no prefs
//        push(context, HomePage(), replace: true);
//      }
//    });
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
            StreamBuilder<bool>(
                //_streamController.strem faz a stream comecar a observar a variável de Future
                stream: _bloc.buttomStream,
                //valor incial do streamBuilder. Previne snapshot.data acessar null e dá error
                initialData: false,
                builder: (context, snapshot) {
                  return AppButton(
                    //Widget AppButton criado no arquivo app_button.dart
                    "Entrar",
                    onPressed: _onClickEntrar,
                    showProgress: snapshot.data,
                  );
                }),
          ],
        ),
      ),
    );
  }

  _onClickEntrar() async {
    bool formOk = _formKey.currentState
        .validate(); //O validate() chama o validator em todos os TextFormField
    if (!formOk) return; //validação não está ok
    String login = _tLogin.text;
    String senha = _tSenha.text;

    print("Email :$login, senha $senha");

    ApiResponse response = await _bloc.login(login, senha);

    if (response.ok) {
      Usuario usuario = response.result;

      print(">>>Usuário: $usuario");

      push(context, HomePage(), replace: true);
    } else {
      alert(context, response.mensagem);
      print("Login incorreto");
    }
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

  //Inverso de initstate
  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }
}
