import 'package:equatable/equatable.dart';

abstract class CurrencyState extends Equatable {}

// Get Currency Code

class CurrencyCodeInitialState extends CurrencyState {
  @override
  List<Object?> get props => [];
}

class CurrencyCodeNoInternetState extends CurrencyState {
  @override
  List<Object?> get props => [];
}

class CurrencyCodeLoadingState extends CurrencyState {
  @override
  List<Object?> get props => [];
}

class CurrencyCodeNoDataState extends CurrencyState {
  @override
  List<Object?> get props => [];
}

class CurrencyCodeLoadedState extends CurrencyState {
  List<dynamic> currencyCode;
  CurrencyCodeLoadedState({required this.currencyCode});
  @override
  List<Object?> get props => [currencyCode];
}

class CurrencyCodeErrorState extends CurrencyState {
  String msg;
  CurrencyCodeErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
}

// Currency Exchange

class CurrencyExchangeInitialState extends CurrencyState {
  @override
  List<Object?> get props => [];
}

class CurrencyExchangeLoadingState extends CurrencyState {
  @override
  List<Object?> get props => [];
}
class CurrencyExchangeNoDataState extends CurrencyState {
  @override
  List<Object?> get props => [];
}

class CurrencyExchangeNoInternetState extends CurrencyState {
  @override
  List<Object?> get props => [];
}

class CurrencyExchangeLoadedState extends CurrencyState {
  String exchnageValue;
  CurrencyExchangeLoadedState({required this.exchnageValue});
  @override
  List<Object?> get props => [exchnageValue];
}

class CurrencyExchangeErrorState extends CurrencyState {
  String msg;
  CurrencyExchangeErrorState({required this.msg});
  @override
  List<Object?> get props => [];
}
