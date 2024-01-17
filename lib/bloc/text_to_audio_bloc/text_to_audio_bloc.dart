import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_api/bloc/text_to_audio_bloc/text_to_audio_event.dart';
import 'package:try_api/bloc/text_to_audio_bloc/text_to_audio_state.dart';
import 'package:try_api/model/language_model.dart';
import 'package:try_api/model/text_voice_model.dart';
import 'package:try_api/repository/text_to_audio_repo.dart';


class TextToAudioBloc extends Bloc<TextToAudioEvent, TextToAudioState> {
  TextToAudioRepo repo;
  TextToAudioBloc({required this.repo}) : super(TextToAudioInitialState()) {
    on<FetchAudioLanguage>(_fetchAudioLanguageEvent);
    on<FetchAudioEvent>(_fetchAudioEvent);
    on<SubmitTextEvent>(_submitAudioEvent);
  }
  _fetchAudioEvent(
      FetchAudioEvent event, Emitter<TextToAudioState> emit) async {
    try {
      emit(TextToAudioGetAudioLoadingState());
      // dynamic data = await repo.getTextToAudioVoice(langCode: event.langCode);
      final String response =
          await rootBundle.loadString('assets/text_to_audio_voice.json');
      Map<String, dynamic> jsonData = json.decode(response);
      List<dynamic> resData = jsonData['voices'];
      List<TextVoiceModel> langModel =
          List.from((resData).map((e) => TextVoiceModel.fromJson(e)));
      dynamic data = langModel;
      if (data != null) {
        emit(TextToAudioGetAudioLoadedState(textVoiceModel: data));
      } else {
        emit(TextToAudioGetAudioNoDataState());
      }
    } on SocketException {
      emit(TextToAudioGetAudioNoInternetState());
    } catch (e) {
      emit(TextToAudioGetAudioErrorState(msg: e.toString()));
    }
  }

  _submitAudioEvent(
      SubmitTextEvent event, Emitter<TextToAudioState> emit) async {
    try {
      emit(TextToAudioLoadingState());
      dynamic data =
          repo.getTextToAudioSpeech(textToAudioModel: event.textToAudioModel);
      if (data != null) {
        emit(TextToAudioLoadedState(textToAudioResponseModel: data));
      } else {
        emit(TextToAudioNoDataState());
      }
    } on SocketException {
      emit(TextToAudioNoInternetState());
    } catch (e) {
      emit(TextToAudioErrorState(msg: e.toString()));
    }
  }

  _fetchAudioLanguageEvent(
      FetchAudioLanguage event, Emitter<TextToAudioState> emit) async {
    try {
      emit(TextToAudioGetLanguageLoadingState());
      // dynamic data = repo.getTextToAudioLanguage();

      // for static data
      final String response =
          await rootBundle.loadString('assets/text_to_audio_language.json');
      Map<String, dynamic> jsonData = json.decode(response);
      List<dynamic> resData = jsonData['languages'];
      List<LanguageAudioModel> langModel =
          List.from((resData).map((e) => LanguageAudioModel.fromJson(e)));
      dynamic data = langModel;
      if (data != null) {
        emit(TextToAudioGetLanguageLoadedState(languageAudioModel: data));
      } else {
        emit(TextToAudioGetLanguageNoDataState());
      }
    } on SocketException {
      emit(TextToAudioGetLanguageNoInternetState());
    } catch (e) {
      emit(TextToAudioGetLanguageErrorState(msg: e.toString()));
    }
  }
}
