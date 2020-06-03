import 'package:carros/pages/login/login_page.dart';
import 'package:carros/pages/login/usuario.dart';
import 'package:carros/utils/nav.dart';
import 'package:carros/utils/prefs.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  UserAccountsDrawerHeader _header(Usuario user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user.nome ?? "..."),
      accountEmail: Text(user.email ?? "..."),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.urlFoto ?? ""),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<Usuario> future = Usuario.get();

    return SafeArea(
      //SafeArea deixa o drawer sobrebor a barra superior do android(Onde tem o wifi, hora etc)
      child: Drawer(
        child: ListView(
          children: <Widget>[
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                Usuario user = snapshot.data;
                return user != null
                    ? _header(user)
                    : Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
              },
            ),
            ListTile(
                //Aula71
                leading: Icon(Icons.playlist_add_check),
                title: Text("Pedidos"),
                subtitle: Text("Visualizar Pedidos de venda"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print("clicou drawer list pedidos");
                  Navigator.pop(context); //Similar ao alertDialog
                }),
            ListTile(
                leading: Icon(Icons.people),
                title: Text("Clientes"),
                subtitle: Text("Lista de clientes"),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  print("clicou drawer list clientes");
                  Navigator.pop(context); //Similar ao alertDialog
                }),
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
