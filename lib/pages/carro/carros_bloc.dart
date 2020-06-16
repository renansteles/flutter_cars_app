import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';

class CarrosBloc {
  var _streamController = StreamController<List<Carro>>();

  Stream<List<Carro>> get stream => _streamController.stream;

  Future<List<Carro>> loadCarros(String tipo) async {
    try {
      //Lista de carros fica esperando retorno da Api pelo await
      List<Carro> carros = await CarrosApi.getCarros(tipo);

      //Adiciona na strem a lista, e quem escuta a stream pode verificar seu valor
      _streamController.add(carros);

      //Retorna lista de carros
      return carros;
    } on Exception catch (e) {
      _streamController.addError(e); //public a exception na stream
    }
  }

  dispose() {
    _streamController.close();
  }
}
