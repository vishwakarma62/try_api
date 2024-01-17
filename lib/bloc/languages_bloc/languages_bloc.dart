import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_api/bloc/languages_bloc/languages_event.dart';
import 'package:try_api/bloc/languages_bloc/languages_state.dart';
import 'package:try_api/repository/languages_repo.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageRepo repo = LanguageRepoImpl();

  LanguageBloc({required this.repo}) : super(LanguageInitialState()) {
    on<FetchLanguageEvent>(_onFetchLanguage);
  }

  _onFetchLanguage(
      FetchLanguageEvent event, Emitter<LanguageState> emit) async {
    try {
      emit(LanguageLoadingtState());
      dynamic data = await repo.getLanguageData();
      if (data != null) {
        emit(
          LanguageSuccessState(languageModel: data),
        );
      } else {
        emit(LanguageNoDatatState());
      }
    } on SocketException {
      emit(LanguageNoInternetState());
    } catch (e) {
      emit(
        LanguageErrorState(
          msg: e.toString(),
        ),
      );
    }
  }
}
