import 'package:carros/pages/carro/Loripsum_api.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarroPage extends StatefulWidget {
  Carro carro;
  CarroPage(this.carro);

  @override
  _CarroPageState createState() => _CarroPageState();
}

class _CarroPageState extends State<CarroPage> {
  final _loripsumBloc = LoripsumBloc();

  @override
  void initState() {
    super.initState();
    _loripsumBloc.fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.carro.nome),
        actions: [
          IconButton(
            icon: Icon(Icons.place),
            onPressed: _onClickMapa,
          ),
          IconButton(
            icon: Icon(Icons.videocam),
            onPressed: _onClickVideo,
          ),
          PopupMenuButton<String>(
            onSelected: (String valor) => _onClickPopupMenu(valor),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: "Editar",
                  child: Text('Editar'),
                ),
                PopupMenuItem(
                  value: "Deletar",
                  child: Text('Deletar'),
                ),
                PopupMenuItem(
                  value: "Compartilhar",
                  child: Text('Compartilhar'),
                ),
              ];
            },
          ),
        ],
      ),
      body: _body(),
    );
  }

  _body() {
    return Container(
      padding: EdgeInsets.all(16),
      child: ListView(
        children: [
          Image.network(widget.carro.urlFoto),
          _bloco1(),
          Divider(),
          _bloco2(),
        ],
      ),
    );
  }

  Row _bloco1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            text(widget.carro.nome, fontSize: 20, bold: true),
            Text(
              widget.carro.tipo,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Icon(
                Icons.favorite,
                size: 40,
              ),
              onPressed: _onClickFavorito,
            ),
            IconButton(
              icon: Icon(Icons.share),
              onPressed: _onClickCompartilhar,
            ),
          ],
        ),
      ],
    );
  }

  _bloco2() {
    return Column(
      children: [
        SizedBox(height: 20),
        text(widget.carro.descricao, fontSize: 16, bold: true),
        SizedBox(height: 20),
        StreamBuilder<String>(
          stream: _loripsumBloc.stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return text(snapshot.data);
          },
        ),
      ],
    );
  }

  void _onClickMapa() {}

  void _onClickVideo() {}

  _onClickPopupMenu(String valor) {
    switch (valor) {
      case "Editar":
        print("Editar!");
        break;
      case "Deletar":
        print("Deletar!");
        break;
      case "Compartilhar":
        print("Compartilhar!");
        break;
    }
  }

  void _onClickFavorito() {}

  void _onClickCompartilhar() {}

  @override
  void dispose() {
    super.dispose();
    _loripsumBloc.dispose();
  }
}
