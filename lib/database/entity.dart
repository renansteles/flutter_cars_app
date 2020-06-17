//Indica que todos que herdarem dessa classe tem que possuir o método toJson que agora se chama toMap.
abstract class Entity {
  Map<String, dynamic> toMap();
}
