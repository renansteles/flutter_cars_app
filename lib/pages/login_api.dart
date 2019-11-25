import 'dart:convert';

import 'package:carros/pages/usuario.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  //Métodos ASYNC retornam dados futuros
  static Future<Usuario> login(String login, String senha) async {
    var url = 'http://carros-springboot.herokuapp.com/api/v2/login';


    Map<String, String > headers  = {
      "Content-Type" : "application/json"
    };

    var parametros = {
      "username" : login,
      "password" : senha,
    };

    String string = json.encode( parametros ); //Converte para o padrão do Header que é json.
    print(">>>$string");

    var response = await http.post(url, body: string /*parametros*/, headers: headers);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    //Convertendo a string do BODY para Map
	Map mapResponse = json.decode( response.body );

	final user = Usuario.fromJson( mapResponse );

    return user;
  }
}