import 'dart:html';

import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carro.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_listview.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    //Construtor do TabController recebe a quantidade e o vsync(é TickerProvider),
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 1;
    //Monitorar o _tabController
    _tabController.addListener(() {
      print("Tab: ${_tabController.index}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carros"),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "Clássicos",
            ),
            Tab(
              text: "Esportivos",
            ),
            Tab(
              text: "Luxo",
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CarrosListview(TipoCarro.classicos),
          CarrosListview(TipoCarro.esportivos),
          CarrosListview(TipoCarro.luxo),
        ],
      ),
      drawer: DrawerList(),
    );
  }
}
