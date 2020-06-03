import 'dart:convert';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/prefs.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  //Métodos ASYNC retornam dados futuros
  static Future<ApiResponse<Usuario>> login(String login, String senha) async {
    try {
      var url = 'http://carros-springboot.herokuapp.com/api/v2/login';

      Map<String, String> headers = {"Content-Type": "application/json"};

      var parametros = {
        "username": login,
        "password": senha,
      };

      String string = json
          .encode(parametros); //Converte para o padrão do Header que é json.
      print(">>>$string");

      var response =
          await http.post(url, body: string /*parametros*/, headers: headers);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      //Convertendo a string do BODY para Map
      Map mapResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        final user = Usuario.fromJson(mapResponse);
        user.save();
        Usuario user2 = await Usuario.get();
        print("user2: $user2");
        return ApiResponse.ok(user);
      }

      return ApiResponse.erro(mapResponse['error']);
    } catch (error, exception) {
      print("Erro no login $error > $exception");
      return ApiResponse.erro("Não foi possível fazer o login");
    }
  }
}
