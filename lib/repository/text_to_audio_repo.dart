import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:try_api/config/constant.dart';
import 'package:try_api/model/language_model.dart';
import 'package:try_api/model/text_to_audio_model.dart';
import 'package:try_api/services/user_client.dart';

import '../model/text_to_audio_response_model.dart';
import '../model/text_voice_model.dart';


abstract class TextToAudioRepo {
  Future<List<LanguageAudioModel>> getTextToAudioLanguage();

  Future<List<TextVoiceModel>> getTextToAudioVoice({required String langCode});
  Future<List<TextToAudioResponseModel>> getTextToAudioSpeech(
      {required TextToAudioModel textToAudioModel});
}

class TextToAudioRepoImpl extends TextToAudioRepo {
  Future<List<LanguageAudioModel>> getTextToAudioLanguage() async {
    String url = ApiConstant.CLOUDLABS_LANGUAGES;
    http.Response response = await UserClient.instance.doGetAudio(url);
    Map<String, dynamic> jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonData['languages'];
      List<LanguageAudioModel> langModel =
          List.from((data).map((e) => LanguageModel.fromJson(e)));
      return langModel;
    } else {
      throw response.body;
    }
  }

  Future<List<TextVoiceModel>> getTextToAudioVoice(
      {required String langCode}) async {
    String url = ApiConstant.CLOUDLABS_VOICE + "?language_code=$langCode}";
    http.Response response = await UserClient.instance.doGetAudio(url);
    Map<String, dynamic> jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonData['voices'];
      List<TextVoiceModel> textVoiceModel =
          List.from((data).map((e) => TextToAudioModel.fromJson(e)));
      return textVoiceModel;
    } else {
      throw response.body;
    }
  }

  Future<List<TextToAudioResponseModel>> getTextToAudioSpeech(
      {required TextToAudioModel textToAudioModel}) async {
    String url = ApiConstant.CLOUDLABS_TEXT_TO_VOICE;
    Map<String, dynamic> data = textToAudioModel.toMap();
    http.Response response =
        await UserClient.instance.doGetTextToAudioSpeech(url, data);
    Map<String, dynamic> jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      return [TextToAudioResponseModel.fromJson(jsonData)];
    } else {
      throw response.body;
    }
  }
}
