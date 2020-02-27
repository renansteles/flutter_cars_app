class Usuario {
  String login;
  String nome;
  String email;
  String token;

  List<String> roles;

  //Exemplo de Named Constructor. Padrão muito utilizado no Dart
  // Exemplo tambem de lista de inicialização, onde ao invés das {} é utilizado : para comecar e no ultimo item ;
  Usuario.fromJson(Map<String, dynamic> map)
      : this.login = map["login"],
        this.nome = map["nome"],
        this.email = map["email"],
        this.token = map["token"],
        roles = map["roles"] != null
            ? map["roles"].map<String>((role) => role.toString()).toList()
            : null;

  @override
  String toString() {
    return "Usuário toString: login: $login , nome $nome , email $email, token $token, roles $roles";
  }
}
