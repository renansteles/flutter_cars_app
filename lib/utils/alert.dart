import 'package:flutter/material.dart';

alert(BuildContext context, String msg) {
  showDialog(
      context: context,
      barrierDismissible: false, //clicando fora do dialog não fecha
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text("Atenção"),
            content: Text(msg),
            actions: <Widget>[
              FlatButton(
                child: Text("ok"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      });
}
