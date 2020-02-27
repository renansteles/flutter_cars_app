import 'package:carros/pages/carro/carro.dart';

class CarrosApi {
  static List<Carro> getCarros() {
    final carros = List<Carro>();
	carros.add(Carro(nome: "Corsinha Wind", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Tucker.png"));
	carros.add(Carro(nome: "Celtinha Malasombrado", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Tucker.png"));
	carros.add(Carro(nome: "Fiat Uno", urlFoto: "http://www.livroandroid.com.br/livro/carros/classicos/Tucker.png"));

	return carros;
  }
}
