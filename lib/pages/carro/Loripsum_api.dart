import 'dart:async';
import 'package:http/http.dart' as http;

class LoripsumBloc {
  final _streamController = StreamController<String>();
  Stream<String> get stream => _streamController.stream;
  fetch() async {
    try {
      String s = await LoripsumApi.getLoripsum();
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
    var url = 'https://loripsum.net/api';
    print("LORIPSUM_API GET> $url");
    var response = await http.get(url);

    String text = response.body;
    print("LORIPSUM_API GET TEXT> $text");

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");
    return text;
  }
}
