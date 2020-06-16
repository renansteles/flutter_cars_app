import 'package:carros/drawer_list.dart';
import 'package:carros/pages/carro/carros_api.dart';
import 'package:carros/pages/carro/carros_page.dart';
import 'package:carros/utils/prefs.dart';
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
    _initTabs();
  }

  _initTabs() async {
    //Construtor do TabController recebe a quantidade e o vsync(é TickerProvider),
    _tabController = TabController(length: 3, vsync: this);

    //O Todo codigo comentado é subistituido usando async e await. Porem async a await sempre retornam um Future
//    Future<int> futureTab = Prefs.getInt("tabIdx");
//    futureTab.then((int indexTab) {
//      _tabController.index = indexTab;
//    });
    int indexTab = await Prefs.getInt("tabIdx");
    _tabController.index = indexTab;

    //Monitorar o _tabController
    _tabController.addListener(() {
      //Salvando no sharedPreferences o index da ultima tab Aberta
      Prefs.setInt("tabIdx", _tabController.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("HOME BUILD");
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
          CarrosPage(TipoCarro.classicos),
          CarrosPage(TipoCarro.esportivos),
          CarrosPage(TipoCarro.luxo),
        ],
      ),
      drawer: DrawerList(),
    );
  }
}
