import 'dart:async';
import 'package:http/http.dart' as http;

class LoripsumBloc {
  //Variavel para salvar dados em cache. Usada no if ternario ??
  static String lorim;
  final _streamController = StreamController<String>();
  Stream<String> get stream => _streamController.stream;
  fetch() async {
    try {
      //Se variavel nao é nula, retorna ela.
      String s = lorim ?? await LoripsumApi.getLoripsum();
      _streamController.add(s);
    } on Exception catch (e) {
      _streamController.addError(e); //public a exception na stream
    }
  }

  dispose() {
    _streamController.close();
  }
}

class LoripsumApi {
  static Future<String> getLoripsum() async {
//    var url = 'https://loripsum.net/api';
	var url = 'https://baconipsum.com/api/?type=meat-and-filler';
    print("LORIPSUM_API GET> $url");
    var response = await http.get(url);

    String text = response.body;
    print("LORIPSUM_API GET TEXT> $text");

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");
	text = text.replaceAll("[", "");
	text = text.replaceAll("]", "");
    return text;
  }
}
