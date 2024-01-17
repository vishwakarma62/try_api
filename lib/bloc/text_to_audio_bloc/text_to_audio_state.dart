import 'package:equatable/equatable.dart';
import 'package:try_api/model/language_model.dart';
import 'package:try_api/model/text_to_audio_response_model.dart';
import 'package:try_api/model/text_voice_model.dart';

abstract class TextToAudioState extends Equatable {}

// Text To Audio Speech

class TextToAudioInitialState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioLoadingState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioNoInternetState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioNoDataState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioLoadedState extends TextToAudioState {
  TextToAudioResponseModel textToAudioResponseModel;
  TextToAudioLoadedState({required this.textToAudioResponseModel});
  @override
  List<Object?> get props => [textToAudioResponseModel];
}

class TextToAudioErrorState extends TextToAudioState {
  String msg;
  TextToAudioErrorState({required this.msg});

  @override
  List<Object?> get props => [msg];
}

// Text to Audio Get Audio Voice

class TextToAudioGetAudioInitialState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioGetAudioLoadingState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioGetAudioNoInternetState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioGetAudioNoDataState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioGetAudioLoadedState extends TextToAudioState {
  List<TextVoiceModel> textVoiceModel;
  TextToAudioGetAudioLoadedState({required this.textVoiceModel});
  @override
  List<Object?> get props => [textVoiceModel];
}

class TextToAudioGetAudioErrorState extends TextToAudioState {
  String msg;
  TextToAudioGetAudioErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
}

// Text to Audio Get Audio Language

class TextToAudioGetLanguageInitialState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioGetLanguageLoadingState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioGetLanguageNoInternetState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioGetLanguageNoDataState extends TextToAudioState {
  @override
  List<Object?> get props => [];
}

class TextToAudioGetLanguageLoadedState extends TextToAudioState {
  List<LanguageAudioModel> languageAudioModel;
  TextToAudioGetLanguageLoadedState({required this.languageAudioModel});
  @override
  List<Object?> get props => [languageAudioModel];
}

class TextToAudioGetLanguageErrorState extends TextToAudioState {
  String msg;
  TextToAudioGetLanguageErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
}
