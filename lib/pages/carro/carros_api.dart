import 'package:carros/database/carro_dao.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TipoCarro {
  static final String classicos = "classicos";
  static final String esportivos = "esportivos";
  static final String luxo = "luxo";
}

class CarrosApi {
  static Future<List<Carro>> getCarros(String tipo) async {
    Usuario usuario = await Usuario.get();
    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${usuario.token}",
    };
    print("HEADERS > $headers");
    var url = "http://carros-springboot.herokuapp.com/api/v2/carros/tipo/$tipo";
    print("GET > $url");

    //Sempre que utilizar await, o método tem que ser async. E desse modo, o método tem que
    // retornar um Future
    //await Future.delayed(Duration(seconds: 5));

    var response = await http.get(url, headers: headers);

    String stringResponse = response.body;
    print("Json > $stringResponse");

    //json vem de pacote dart convert
    List list = json.decode(stringResponse);

    List<Carro> carros = list.map((map) => Carro.fromMap(map)).toList();
    final dao = CarroDAO();

    //Forma 1
//    for (Carro map in list) {
//      dao.save(map);
//    }
    //Forma 2
//    list.forEach((carro) {dao.save(carro);});
    //Forma 3
    carros.forEach(dao.save);

    return carros;
  }
}
