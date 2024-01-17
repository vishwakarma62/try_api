import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:try_api/config/constant.dart';
import 'package:try_api/model/language_model.dart';
import 'package:try_api/model/translate_model.dart';
import 'package:try_api/services/user_client.dart';


abstract class LanguageRepo {
  Future<List<LanguageModel>> getLanguageData();
  Future<dynamic> getTranslateData({required TranslateModel translateModel});
}

class LanguageRepoImpl extends LanguageRepo {
  @override
  Future<List<LanguageModel>> getLanguageData() async {
    String url = ApiConstant.GET_LANGUAGE;
    http.Response response = await UserClient.instance.doGetLanguage(url);
    Map<String, dynamic> jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      var data1 = jsonData['data'];
      List<dynamic> data2 = data1['languages'];
      List<LanguageModel> langData =
          List.from((data2).map((e) => LanguageModel.fromJson(e)));
      return langData;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<TranslateModel>> getTranslateData(
      {required TranslateModel translateModel}) async {
    String url = ApiConstant.TRANSLATION;
    Map<String, dynamic> data = translateModel.toJson();
    http.Response response =
        await UserClient.instance.doTranslation(url, body: data);
    Map<String, dynamic> jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> innerData = jsonData['data'];
      String translatedText = innerData['translatedText'];
      TranslateModel translatedModel = TranslateModel.fromJson({
        'text': translatedText,
      });
      return [translatedModel];
    } else {
      throw response.body;
    }
  }
}
