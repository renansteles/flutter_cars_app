import 'package:carros/pages/login/login_page.dart';
import 'package:carros/utils/nav.dart';
import 'package:flutter/material.dart';


class DrawerList extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return SafeArea( //SafeArea deixa o drawer sobrebor a barra superior do android(Onde tem o wifi, hora etc)
			child: Drawer(
				child: ListView(
					children: <Widget>[
//				Container(
//					color: Colors.blueAccent,
//					height: 50,
//				),
						UserAccountsDrawerHeader(
							accountName: Text("Renan Teles"),
							accountEmail: Text("renansteles@gmail.com"),
							currentAccountPicture: CircleAvatar(
//						backgroundColor: Colors.redAccent,
								backgroundImage: AssetImage(
									"assets/images/1.jpg"),
							),
						),
						ListTile( //Aula71
							leading: Icon(Icons.playlist_add_check),
							title: Text("Pedidos"),
							subtitle: Text("Visualizar Pedidos de venda"),
							trailing: Icon(Icons.arrow_forward),
							onTap: () {
								print("clicou drawer list pedidos");
								Navigator.pop(context); //Similar ao alertDialog
							}
						),
						ListTile(
							leading: Icon(Icons.people),
							title: Text("Clientes"),
							subtitle: Text("Lista de clientes"),
							trailing: Icon(Icons.arrow_forward),
							onTap: () {
								print("clicou drawer list clientes");
								Navigator.pop(context); //Similar ao alertDialog
							}
						),
						ListTile(
							leading: Icon(Icons.exit_to_app),
							title: Text("Sair"),
							trailing: Icon(Icons.arrow_forward),
							onTap: () {
								_onClickLogout(context);
							},
						)
					],
				),
			),
		);
	}

	void _onClickLogout(BuildContext context) {
		Navigator.pop(context);
		push(context, LoginPage(),
			replace: true); //Parametro como true para não empilhar as telas
	}
}
