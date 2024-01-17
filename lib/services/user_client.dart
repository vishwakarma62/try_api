import 'package:http/http.dart' as http;

class UserClient {
  static final UserClient instance = UserClient._internal();
  factory UserClient() {
    return instance;
  }
  UserClient._internal();

  Future<http.Response> doGetLanguage(String url,
      {Map<String, String>? header}) async {
    Map<String, String> head = {
      "X-RapidAPI-Key": "59a1105eacmsh68f7e877c2172f5p1f0176jsn4fe7afcde46c",
      "X-RapidAPI-Host": "text-translator2.p.rapidapi.com"
    };
    if (header != null) {
      head.addAll(header);
    }
    return http.get(Uri.parse(url), headers: head);
  }

  Future<http.Response> doTranslation(String url,
      {required Map<String, dynamic> body}) async {
    Map<String, String> head = {
      'X-RapidAPI-Key': '59a1105eacmsh68f7e877c2172f5p1f0176jsn4fe7afcde46c',
      'X-RapidAPI-Host': 'text-translator2.p.rapidapi.com',
    };
    var data = {
      'text': body["text"],
      'target_language': body["target_language"],
      'source_language': body["source_language"],
    };
    return await http.post(Uri.parse(url), headers: head, body: data);
  }

  Future<http.Response> doGetCurrencyLanguageCode(String url,
      {Map<String, String>? header}) async {
    Map<String, String> head = {
      "X-RapidAPI-Key": "59a1105eacmsh68f7e877c2172f5p1f0176jsn4fe7afcde46c",
      "X-RapidAPI-Host": "currency-exchange.p.rapidapi.com"
    };
    if (header != null) {
      head.addAll(header);
    }
    return http.get(Uri.parse(url), headers: head);
  }

  Future<http.Response> doCurrencyExchange(String url,
      {Map<String, String>? header}) async {
    Map<String, String> head = {
      "X-RapidAPI-Key": "59a1105eacmsh68f7e877c2172f5p1f0176jsn4fe7afcde46c",
      "X-RapidAPI-Host": "currency-exchange.p.rapidapi.com"
    };
    if (header != null) {
      head.addAll(header);
    }
    // var data = {
    //   'source_language': body["source_language"],
    //   'target_language': body["target_language"],
    //   'text': body["translatedText"]
    // };

    return http.get(Uri.parse(url), headers: head);
  }

  Future<http.Response> doGetAudio(String url,
      {Map<String, String>? header}) async {
    Map<String, String> head = {
      "X-RapidAPI-Key": "59a1105eacmsh68f7e877c2172f5p1f0176jsn4fe7afcde46c",
      "X-RapidAPI-Host": "cloudlabs-text-to-speech.p.rapidapi.com"
    };
    if (header != null) {
      head.addAll(header);
    }
    return http.get(Uri.parse(url), headers: head);
  }

  Future<http.Response> doGetTextToAudioSpeech(
    String url,
    Map<String, dynamic>? body, {
    Map<String, String>? header,
  }) async {
    Map<String, String> head = {
      "X-RapidAPI-Key": "59a1105eacmsh68f7e877c2172f5p1f0176jsn4fe7afcde46c",
      "X-RapidAPI-Host": "cloudlabs-text-to-speech.p.rapidapi.com"
    };
    if (header != null) {
      head.addAll(header);
    }
    return http.get(Uri.parse(url), headers: head);
  }
}
