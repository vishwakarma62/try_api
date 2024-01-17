import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_api/bloc/stphen_king_villens_bloc/stphen_king_villains_event.dart';
import 'package:try_api/bloc/stphen_king_villens_bloc/stphen_king_villains_state.dart';

import '../../repository/stphen_king_books_repo.dart';

class StphenKingVillainsBloc
    extends Bloc<StphenKingVillainsEvent, StphenKingVillainsState> {
  StphenKingBooksRepo repo;
  StphenKingVillainsBloc(this.repo) : super(StphenKingVillainsInitialState()) {
    on<FetchStphenKingVillainByIdEvent>(_onFetchStphenKingVillainByIdEvent);
  }
  _onFetchStphenKingVillainByIdEvent(FetchStphenKingVillainByIdEvent event,
      Emitter<StphenKingVillainsState> emit) async {
    try {
      emit(StphenKingVillainsLoadingState());
      dynamic data = await repo.getStphenKingVillainsById(id: event.id);
      if (data != null) {
        emit(StphenKingVillainsLoadedState(stphenKingBookVillainModel: data));
      } else {
        emit(StphenKingVillainsNoDataState());
      }
    } on SocketException {
      emit(StphenKingVillainsNoInternetState());
    } catch (e) {
      print(e.toString());
      emit(
        StphenKingVillainsErrorState(
          msg: e.toString(),
        ),
      );
    }
  }
}
