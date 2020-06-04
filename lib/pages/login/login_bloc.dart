import 'dart:async';

import 'package:carros/pages/api_response.dart';
import 'package:carros/pages/login/login_api.dart';
import 'package:carros/pages/login/usuario.dart';

class LoginBloc {
  final _streamController = StreamController<bool>();

  get buttomStream => _streamController.stream;

  Future<ApiResponse<Usuario>> login(String login, String senha) async {
    _streamController.add(true); //O add envia informações para a Stream

    ApiResponse response = await LoginApi.login(login, senha);

    _streamController.add(false); //O add envia informações para a Stream

    return response;
  }

  dispose() {
    _streamController.close(); //Liberando da memoria o controller
  }
}
