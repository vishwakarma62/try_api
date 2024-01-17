import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_api/bloc/stphen_king_books_bloc/stphen_king_books_event.dart';
import 'package:try_api/bloc/stphen_king_books_bloc/stphen_king_books_state.dart';
import 'package:try_api/repository/stphen_king_books_repo.dart';
class StphenKingBooksBloc
    extends Bloc<StphenKingBooksEvent, StphenKingBooksState> {
  StphenKingBooksRepo repo;
  StphenKingBooksBloc(this.repo) : super(StphenKingBooksInitialState()) {
    on<FetchStphenKingBooksEvent>(_fetchStphenKingBooksEvent);
    on<FetchStphenKingBooksByIdEvent>(_fetchStphenKingBooksByIdEvent);
  }

  void _fetchStphenKingBooksEvent(FetchStphenKingBooksEvent event,
      Emitter<StphenKingBooksState> emit) async {
    try {
      emit(StphenKingBooksLoadingState());
      dynamic data = await repo.getStphenKingBooks();
      if (data != null) {
        emit(StphenKingBooksLoadedState(stphenKingBooksModels: data));
      } else {
        emit(StphenKingBooksNoDataState());
      }
    } on SocketException {
      emit(StphenKingBooksNoInternetState());
    } catch (e) {
      emit(
        StphenKingBooksErrorState(
          msg: e.toString(),
        ),
      );
    }
  }

  void _fetchStphenKingBooksByIdEvent(FetchStphenKingBooksByIdEvent event,
      Emitter<StphenKingBooksState> emit) async {
    try {
      emit(StphenKingBooksByIdLoadingState());
      dynamic data = await repo.getStphenKingBooksById(id: event.id);
      if (data != null) {
        emit(StphenKingBooksByIdLoadedState(stphenKingBooksModels: data));
      } else {
        emit(StphenKingBooksByIdNoDataState());
      }
    } on SocketException {
      emit(StphenKingBooksByIdNoInternetState());
    } catch (e) {
      emit(
        StphenKingBooksByIdErrorState(msg: e.toString()),
      );
    }
  }
}
