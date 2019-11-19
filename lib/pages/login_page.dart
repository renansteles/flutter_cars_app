//nome de classe é sempre com letras minusculas e com underline no meio
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
	final _tLogin = TextEditingController(text : "renan");
	final _tSenha = TextEditingController(text: "123");

	final _formKey = GlobalKey<FormState>();

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
		return Form( //Formulario visualmente não faz nada. O key é o estado do formulario
			key: _formKey,
			child: Container(
				padding: EdgeInsets.all(16),
				// Tamanho padrão do Material Design
				child: ListView(
					children: <Widget>[
						_textForm(
							"Email", "Digite seu email", controller: _tLogin, validatorParametro : _validacaoLogin),
						SizedBox(
							height: 10,
						),
						_textForm("Senha", "Digite sua senha", password: true,
							controller: _tSenha, validatorParametro : _validacaoSenha),
						SizedBox(
							height: 20,
						),
						_button("Entrar", () {
							_onClickEntrar();
						}),
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
				onPressed: onPressed, //Enquanto o botão não estiver o método onPressed, ele fica desativado. Fazer teste comentando.
			),
		);
	}

	//O que está entre {} é um NamedArgument. Não é obrigatório utilizá-lo quando chamar o método, porem se tiver o @required, fica obrigatório.
	_textForm(String label, String hint,
		{bool password = false, TextEditingController controller, FormFieldValidator<String> validatorParametro, }) {
		return TextFormField(
			controller: controller,
			obscureText: password,
			validator: validatorParametro, //Validator vindo por parametro da funcção
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
		bool formOk  = _formKey.currentState.validate(); //O validate() chama o validator em todos os TextFormField
		if( !formOk ) return; //validação não está ok
		String login = _tLogin.text;
		String senha = _tSenha.text;

		print("Email :$login, senha $senha");
	}

	String _validacaoLogin(String text){
		return (text.isEmpty) ? "Digite o login" : null; //retorno nulo siginifica que está correto
	}

	String _validacaoSenha(String text){
		if (text.isEmpty)
			return "Digite a senha";
		if (text.length < 3)
			return "Senha precisa ter pelo menos 3 caracteres";

		return  null; //retorno nulo siginifica que está correto
	}
}
