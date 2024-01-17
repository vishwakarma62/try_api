import 'package:equatable/equatable.dart';
import 'package:try_api/model/translate_model.dart';

abstract class TranslationState extends Equatable {}

class TranslationInitialState extends TranslationState {
  @override
  List<Object?> get props => [];
}

class TranslationNoInternetState extends TranslationState {
  @override
  List<Object?> get props => [];
}

class TranslationLoadingtState extends TranslationState {
  @override
  List<Object?> get props => [];
}


class TranslationNoDatatState extends TranslationState {
  @override
  List<Object?> get props => [];
}

class TranslationErrorState extends TranslationState {
  String msg;
  TranslationErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
  @override
  String toString() {
    return msg;
  }
}

class TranslationSuccessState extends TranslationState {
  List<TranslateModel> translateModel;
  TranslationSuccessState({required this.translateModel});
  @override
  List<Object?> get props => [translateModel];
}


