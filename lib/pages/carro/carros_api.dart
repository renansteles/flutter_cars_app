import 'package:carros/pages/carro/carro.dart';

class CarrosApi {
  static Future<List<Carro>> getCarros() async {
    final carros = List<Carro>();

    //Sempre que utilizar await, o método tem que ser async. E desse modo, o método tem que
	// retornar um Future
    await Future.delayed(Duration(seconds: 5));

	carros.add(Carro(nome: "Corsinha Wind", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Tucker.png"));
	carros.add(Carro(nome: "Celtinha Malasombrado", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Tucker.png"));
	carros.add(Carro(nome: "Fiat Uno", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Tucker.png"));

	return carros;
  }
}
