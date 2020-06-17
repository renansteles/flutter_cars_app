import 'dart:async';

import 'package:carros/database/database_helper.dart';
import 'package:carros/database/entity.dart';
import 'package:sqflite/sqflite.dart';

// Data Access Object
//Classe abstrata, não pode ser instanciada. Ou seja, não pode dá new...
//A necessidade de criar essa classe é para que não precise criar uma dao com todos os metodos para cada tabela.
//Cria só uma que importa essa e os metodos dessa classe abstrata

//A classe generica tem que herdar de Entity <T extends Entity>. Por exemplo Carro extends Entity
abstract class GenericDAO<T extends Entity> {
  Future<Database> get db => DatabaseHelper.getInstance().db;

  //Método abstrato
  String get nomeTabela;

  //Outro método abstrato
  T fromMap(Map<String, dynamic> map);

  Future<int> save(T entidade) async {
    var dbClient = await db;
    var id = await dbClient.insert(nomeTabela, entidade.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print('Salvando Carro id: $id');
    return id;
  }

  Future<List<T>> findAll() async {
    final dbClient = await db;

    final list = await dbClient.rawQuery('select * from $nomeTabela');

    return list.map<T>((json) => fromMap(json)).toList();
  }

  //findByTipo removido. Já que é especifico de carro e não é generico

  Future<T> findById(int id) async {
    var dbClient = await db;
    final list =
        await dbClient.rawQuery('select * from $nomeTabela where id = ?', [id]);

    if (list.length > 0) {
      return fromMap(list.first);
    }

    return null;
  }

  Future<bool> exists(id) async {
    T c = await findById(id);
    var exists = c != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final list = await dbClient.rawQuery('select count(*) from $nomeTabela');
    return Sqflite.firstIntValue(list);
  }

  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete('delete from $nomeTabela where id = ?', [id]);
  }

  Future<int> deleteAll() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from $nomeTabela');
  }
}
