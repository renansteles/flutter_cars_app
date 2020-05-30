import 'package:carros/pages/carro/carro.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CarrosApi {
  static Future<List<Carro>> getCarros() async {
    var url = "http://carros-springboot.herokuapp.com/api/v1/carros";
    print("GET > $url");

    //Sempre que utilizar await, o método tem que ser async. E desse modo, o método tem que
    // retornar um Future
    await Future.delayed(Duration(seconds: 5));

    var response = await http.get(url);

    String stringResponse = response.body;
    print("Json > $stringResponse");

    //json vem de pacote dart convert
    List list = json.decode(stringResponse);

    List<Carro> carros = List<Carro>();

    for (Map map in list) {
      Carro c = Carro.fromJson(map);
      carros.add(c);
    }
    //ao invez do for, uma boa pratica é usar map
    //final carros = list.map<Carro>((map)=>Carro.fromJson(map)).toList();
    // (map) => Carro...  é igual a (map) { return Carro...; }

    return carros;
  }
}
