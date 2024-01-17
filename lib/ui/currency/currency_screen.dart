import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_api/bloc/currency_bloc/currency_bloc.dart';
import 'package:try_api/model/currency_model.dart';

import '../../bloc/currency_bloc/currency_event.dart';
import '../../bloc/currency_bloc/currency_state.dart';


class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String dropdownvalue1 = 'From';
  String dropdownvalue2 = '  To  ';
  List<dynamic> countryData = [];
  bool isLoading = false;

  TextEditingController inputTextCtr = TextEditingController();
  String exchnageValue = "";
  late CurrencyBloc currencyBloc;
  void initState() {
    super.initState();
    currencyBloc = context.read<CurrencyBloc>();
    currencyBloc.add(FetchCurrencyCode());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          title: Text(
            "Currency Converter",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: BlocConsumer<CurrencyBloc, CurrencyState>(
            listener: (context, state) {
              if (state is CurrencyCodeLoadedState) {
                countryData = state.currencyCode;
              }
            },
            builder: (context, state) {
              return Column(
                children: [
                  TextFormField(
                    controller: inputTextCtr,
                    maxLines: 1,
                    minLines: 1,
                    keyboardType: TextInputType.numberWithOptions(
                        decimal: true, signed: false),
                    inputFormatters: [LengthLimitingTextInputFormatter(16)],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Enter the value",
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                        child: PopupMenuButton(
                          tooltip: "",
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${dropdownvalue1}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.arrow_drop_down_sharp,
                                    color: Colors.white)
                              ],
                            ),
                          ),
                          itemBuilder: (context) => List.generate(
                            countryData.length,
                            (index) => PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  dropdownvalue1 = countryData[index];
                                  // currentLanguage =
                                  //     countryData[index].code!;
                                });
                              },
                              child: Text(
                                countryData[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.currency_exchange,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                        ),
                        child: PopupMenuButton(
                          tooltip: "",
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.blue,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "${dropdownvalue2}",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Icon(Icons.arrow_drop_down_sharp,
                                    color: Colors.white)
                              ],
                            ),
                          ),
                          itemBuilder: (context) => List.generate(
                            countryData.length,
                            (index) => PopupMenuItem(
                              onTap: () {
                                setState(() {
                                  dropdownvalue2 = countryData[index];
                                  // currentLanguage =
                                  //     countryData[index].code!;
                                });
                              },
                              child: Text(
                                countryData[index],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  BlocConsumer<CurrencyBloc, CurrencyState>(
                    listener: (context, state) {
                      if (state is CurrencyExchangeLoadedState) {
                        var resData = double.parse(state.exchnageValue);
                        var inputData = double.parse(inputTextCtr.text);
                        setState(() {
                          isLoading = false;
                          exchnageValue =
                              "${inputTextCtr.text} $dropdownvalue1 = ${resData * inputData} $dropdownvalue2";
                        });
                      }
                      if (state is CurrencyExchangeErrorState) {
                        print(state.msg.toString());
                      }
                    },
                    builder: (context, state) {
                      if (state is CurrencyExchangeLoadingState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: CircularProgressIndicator());
                      }
                      if (state is CurrencyExchangeLoadedState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Text(
                            "${exchnageValue}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    height: 45,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      FocusManager.instance.primaryFocus!.unfocus();
                      if (inputTextCtr.text == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          content: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Please enter amount",
                                style: TextStyle(color: Colors.red[400]),
                              ),
                            ),
                          ),
                        ));
                      } else if (dropdownvalue1 == "From") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          content: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Please select the from value",
                                style: TextStyle(color: Colors.red[400]),
                              ),
                            ),
                          ),
                        ));
                      } else if (dropdownvalue2 == "  To  ") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          backgroundColor: Colors.transparent,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          content: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Please select the to value",
                                style: TextStyle(color: Colors.red[400]),
                              ),
                            ),
                          ),
                        ));
                      } else {
                        currencyBloc.add(
                          SubmitExchangeRate(
                            currencyModel: CurrencyModel(
                              from: dropdownvalue1,
                              to: dropdownvalue2,
                              q: "1",
                            ),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "GET EXCHANGE RATE",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        )),
      ),
    );
  }
}
