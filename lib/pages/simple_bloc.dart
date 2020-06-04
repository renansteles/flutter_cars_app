import 'dart:async';

/*Aula 133. Outras classes Bloc podem usar a classe Generica
* Por heranca: extends SimpleBloc<List<Carros>> no CarrosBloc
* Por composicao  buttonBloc = new SimpleBloc<bool>();
 */
class SimpleBloc<T> {
  final _controller = StreamController<T>();

  Stream<T> get stream => _controller.stream;

  void add(T object) {
    _controller.add(object);
  }

  void addError(Object error) {
    if (!_controller.isClosed) {
      _controller.addError(error);
    }
  }

  void dispose() {
    _controller.close();
  }
}
