import 'dart:async';

import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carro_page.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';

class CarrosListview extends StatefulWidget {
  String tipo;

  CarrosListview(this.tipo);

  @override
  _CarrosListviewState createState() => _CarrosListviewState();
}

class _CarrosListviewState extends State<CarrosListview>
    with AutomaticKeepAliveClientMixin<CarrosListview> {
  List<Carro> carros;

  var _streamController = StreamController<List<Carro>>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    //o initState é chamado apenas 1 vez na inicialização do StateFull
    super.initState();
    _loadCarros();
  }

  _loadCarros() async {
    List<Carro> carros = await CarrosApi.getCarros(widget.tipo);
    _streamController.add(carros);
  }

  //no build é recomendado não ter logica, apenas exibiçao de dados
  @override
  Widget build(BuildContext context) {
    //não esquecer do super.build(). Já que mudou a var wantKeepAlive tem que avisar a classe mãe
    super.build(context);
    return _body();
  }

  _body() {
    //O streamBuilder é como se fosse um observer que fica observando a List<Carros> e atualiza automaticamente.
    //A vantagem é que não é preciso executar o método build novamente.
    return StreamBuilder(
      stream: _streamController.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Center(
            child: Text("Não foi possível buscar os carros ",
                style: TextStyle(color: Colors.red, fontSize: 20)),
          );
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return _listView(carros);
      },
    );
  }

  Container _listView(List<Carro> carros) {
    //Container geralmente é utilizado para colocar uma margem, padding, espacamento e cores
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView.builder(
          itemCount: carros.length != null ? carros.length : 0,
          itemBuilder: (content, index) {
            Carro c = carros[index];

            return Card(
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Image.network(
                        //Exemplo de if ternário. se null retorna
                        c.urlFoto ??
                            "http://www.livroandroid.com.br/livro/carros/classicos/Tucker.png",
                        width: 150,
                      ),
                    ),
                    Text(
                      c.nome ?? "Sem nome",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      "descrição...",
                      style: TextStyle(fontSize: 16),
                    ),
                    ButtonTheme.bar(
                      child: ButtonBar(
                        children: <Widget>[
                          FlatButton(
                            child: const Text('Detalhes'),
                            onPressed: () => _onClickCarro(c),
                          ),
                          FlatButton(
                            child: const Text('Share'),
                            onPressed: () {
                              /* ... */
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  _onClickCarro(Carro c) {
    push(context, CarroPage(c));
  }
}
