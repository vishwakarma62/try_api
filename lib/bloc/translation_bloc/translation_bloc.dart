import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_api/bloc/translation_bloc/translation_event.dart';
import 'package:try_api/bloc/translation_bloc/translation_state.dart';
import 'package:try_api/repository/languages_repo.dart';


class TranslationBloc extends Bloc<TranslationEvent, TranslationState> {
  LanguageRepo repo = LanguageRepoImpl();

  TranslationBloc({required this.repo}) : super(TranslationInitialState()) {
    on<SubmitTranslationEvent>(_onSubmitTranslation);
  }

  _onSubmitTranslation(
      SubmitTranslationEvent event, Emitter<TranslationState> emit) async {
    try {
      emit(TranslationLoadingtState());
      dynamic data = await repo.getTranslateData(translateModel: event.translateModel);
      if (data != null) {
        emit(
          TranslationSuccessState(translateModel: data),
        );
      } else {
        emit(TranslationNoDatatState());
      }
    } on SocketException {
      emit(TranslationNoInternetState());
    } catch (e) {
      emit(
        TranslationErrorState(
          msg: e.toString(),
        ),
      );
    }
  }
}
