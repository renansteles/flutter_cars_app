import 'package:carros/database/generic_dao.dart';
import 'package:carros/pages/carro/carro.dart';

// Data Access Object
class CarroDAO extends GenericDAO<Carro> {
  @override
  String get nomeTabela => "carro";

  @override
  fromMap(Map<String, dynamic> map) {
    return Carro.fromMap(map);
  }

  Future<List<Carro>> findAllByTipo(String tipo) async {
    final dbClient = await db;

    final list =
        await dbClient.rawQuery('select * from carro where tipo =? ', [tipo]);

    return list.map<Carro>((json) => fromMap(json)).toList();
  }
}
