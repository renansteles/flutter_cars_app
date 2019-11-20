import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String label;
  String hint;
  bool password;
  TextEditingController controller;
  FormFieldValidator<String> validatorParametro;
  TextInputType keyboardTypeParametro;
  TextInputAction textInputActionParametro;
  FocusNode focusNodeParametro;
  FocusNode focoSenha;

  AppText(this.label, this.hint,
      {this.password = false,
      this.controller,
      this.validatorParametro,
      this.keyboardTypeParametro,
      this.textInputActionParametro,
      this.focusNodeParametro,
      this.focoSenha,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: password,
      validator: validatorParametro,
      //Validator vindo por parametro da funcção
      keyboardType: keyboardTypeParametro,
      keyboardAppearance: Brightness.light,
      textInputAction: textInputActionParametro,
      focusNode: focusNodeParametro,
      onFieldSubmitted: (String text) {
        FocusScope.of(context)
            .requestFocus( focoSenha ); //O context vem do Statefull
      },
      style: TextStyle(color: Colors.blue),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.black38, fontSize: 15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
    );
  }
}
