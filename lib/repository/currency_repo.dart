import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:try_api/config/constant.dart';
import 'package:try_api/model/currency_model.dart';
import 'package:try_api/services/user_client.dart';


abstract class CurrencyRepo {
  Future<dynamic> getCurrencyCodeList();
  Future<dynamic> exchangeCurrency({required CurrencyModel currencyModel});
}

class CurrencyRepoImpl extends CurrencyRepo {
  @override
  Future<dynamic> getCurrencyCodeList() async {
    String url = ApiConstant.CURRENCY_LIST_COUNTRY_CODE;
    http.Response response =
        await UserClient.instance.doGetCurrencyLanguageCode(url);
    List<dynamic> jsonData = json.decode(response.body);
    if (response.statusCode == 200) {
      var responseData = jsonData;
      return responseData;
    } else {
      throw Exception();
    }
  }

  @override
  Future<dynamic> exchangeCurrency(
      {required CurrencyModel currencyModel}) async {
    String url =
        "${ApiConstant.CURRENCY_EXCHANGE}?from=${currencyModel.from}&to=${currencyModel.to}&q=${currencyModel.q}";
    http.Response response = await UserClient.instance.doCurrencyExchange(url);
    dynamic responseData = response.body;
    if (response.statusCode == 200) {
      return responseData;
    } else {
      throw Exception();
    }
  }
}
