import 'package:equatable/equatable.dart';
import 'package:try_api/model/language_model.dart';

abstract class LanguageState extends Equatable {}

class LanguageInitialState extends LanguageState {
  @override
  List<Object?> get props => [];
}

class LanguageNoInternetState extends LanguageState {
  @override
  List<Object?> get props => [];
}

class LanguageLoadingtState extends LanguageState {
  @override
  List<Object?> get props => [];
}

class LanguageNoDatatState extends LanguageState {
  @override
  List<Object?> get props => [];
}

class LanguageErrorState extends LanguageState {
  String msg;
  LanguageErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
  @override
  String toString() {
    return msg;
  }
}

class LanguageSuccessState extends LanguageState {
  List<LanguageModel> languageModel;
  LanguageSuccessState({required this.languageModel});
  @override
  List<Object?> get props => [languageModel];
}
