import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_bloc.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:carros/widgets/text_error.dart';
import 'package:flutter/material.dart';

class CarrosPage extends StatefulWidget {
  String tipo;

  CarrosPage(this.tipo);

  @override
  _CarrosPageState createState() => _CarrosPageState();
}

class _CarrosPageState extends State<CarrosPage>
    with AutomaticKeepAliveClientMixin<CarrosPage> {
  List<Carro> carros;

  String get tipo => widget.tipo;

  final _bloc = CarrosBloc();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    //o initState é chamado apenas 1 vez na inicialização do StateFull
    super.initState();
    _bloc.loadCarros(tipo);
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
      stream: _bloc.stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return TextError("Não foi possível buscar os carros");
        }
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        List<Carro> carros = snapshot.data;
        return CarrosListview(carros);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose(); //Liberando controle da memória
  }
}
