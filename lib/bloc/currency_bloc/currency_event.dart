import 'package:equatable/equatable.dart';
import 'package:try_api/model/currency_model.dart';

abstract class CurrencyEvent extends Equatable {}

class FetchCurrencyCode extends CurrencyEvent {
  List<Object?> get props => [];
}

class SubmitExchangeRate extends CurrencyEvent {
  CurrencyModel currencyModel;
  SubmitExchangeRate({required this.currencyModel});
  List<Object?> get props => [currencyModel];
}
