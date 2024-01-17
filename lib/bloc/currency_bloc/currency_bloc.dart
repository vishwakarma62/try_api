import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_api/bloc/currency_bloc/currency_event.dart';
import 'package:try_api/bloc/currency_bloc/currency_state.dart';
import 'package:try_api/repository/currency_repo.dart';


class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  CurrencyRepo repo;
  CurrencyBloc({required this.repo}) : super(CurrencyCodeInitialState()) {
    on<FetchCurrencyCode>(_fetchCurrencyCode);
    on<SubmitExchangeRate>(_submitExchangeRate);
  }
  _fetchCurrencyCode(
      FetchCurrencyCode event, Emitter<CurrencyState> emit) async {
    try {
      emit(CurrencyCodeLoadingState());
      dynamic data = await repo.getCurrencyCodeList();
      if (data != null) {
        emit(CurrencyCodeLoadedState(currencyCode: data));
      } else {
        emit(CurrencyCodeNoDataState());
      }
    } on SocketException {
      emit(CurrencyCodeNoInternetState());
    } catch (e) {
      emit(
        CurrencyCodeErrorState(
          msg: e.toString(),
        ),
      );
    }
  }

  _submitExchangeRate(
      SubmitExchangeRate event, Emitter<CurrencyState> emit) async {
    try {
      emit(CurrencyExchangeLoadingState());
      dynamic data =
          await repo.exchangeCurrency(currencyModel: event.currencyModel);
      if (data != null) {
        emit(CurrencyExchangeLoadedState(exchnageValue: data));
      } else {
        emit(CurrencyExchangeNoDataState());
      }
    } on SocketException {
      emit(CurrencyExchangeNoInternetState());
    } catch (e) {
      emit(CurrencyExchangeErrorState(msg: e.toString()));
    }
  }
}
