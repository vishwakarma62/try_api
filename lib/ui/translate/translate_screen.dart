import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_api/bloc/languages_bloc/languages_event.dart';
import 'package:try_api/bloc/languages_bloc/languages_state.dart';
import 'package:try_api/bloc/translation_bloc/translation_bloc.dart';
import 'package:try_api/bloc/translation_bloc/translation_event.dart';
import 'package:try_api/bloc/translation_bloc/translation_state.dart';
import 'package:try_api/model/translate_model.dart';

import '../../bloc/languages_bloc/languages_bloc.dart';
import '../../model/language_model.dart';


class TranslateScreen extends StatefulWidget {
  const TranslateScreen({super.key});

  @override
  State<TranslateScreen> createState() => _TranslateScreenState();
}

class _TranslateScreenState extends State<TranslateScreen> {
  String dropdownvalue1 = '--Select--';
  String dropdownvalue2 = '--Select--';
  String currentLanguage = '';
  String translationLanguage = '';
  List<LanguageModel> countryData = [];
  TextEditingController inputTextCtr = TextEditingController();
  TextEditingController outputTextCtr = TextEditingController();
  late LanguageBloc languageBloc;
  late TranslationBloc translationBloc;

  void initState() {
    super.initState();
    languageBloc = context.read<LanguageBloc>();
    languageBloc.add(FetchLanguageEvent());

    translationBloc = context.read<TranslationBloc>();
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
            "Translation",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                BlocConsumer<LanguageBloc, LanguageState>(
                  listener: (context, state) {
                    if (state is LanguageNoInternetState) {
                      print("No internet state");
                    }
                    if (state is LanguageSuccessState) {
                      setState(() {
                        countryData = state.languageModel;
                      });
                    }
                    if (state is LanguageErrorState) {
                      print("${state.msg.toString()}");
                    }
                  },
                  builder: (context, state) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Theme(
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
                                      child: Center(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "${dropdownvalue1}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(Icons.arrow_drop_down_sharp,
                                                  color: Colors.white)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemBuilder: (context) => List.generate(
                                      countryData.length,
                                      (index) => PopupMenuItem(
                                        onTap: () {
                                          FocusManager.instance.primaryFocus!
                                              .unfocus();
                                          setState(() {
                                            dropdownvalue1 =
                                                countryData[index].name!;
                                            currentLanguage =
                                                countryData[index].code!;
                                          });
                                        },
                                        child: Text(
                                          countryData[index].name!,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Icon(
                                  Icons.compare_arrows,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Theme(
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
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "${dropdownvalue2}",
                                                style: TextStyle(
                                                    color: Colors.white),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(Icons.arrow_drop_down_sharp,
                                                  color: Colors.white)
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    itemBuilder: (context) => List.generate(
                                      countryData.length,
                                      (index) => PopupMenuItem(
                                        onTap: () {
                                          FocusManager.instance.primaryFocus!
                                              .unfocus();
                                          setState(() {
                                            dropdownvalue2 =
                                                countryData[index].name!;
                                            translationLanguage =
                                                countryData[index].code!;
                                          });
                                          if (inputTextCtr.text != "") {
                                            submitTranslation();
                                          }
                                        },
                                        child: Text(
                                          countryData[index].name!,
                                        ),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: inputTextCtr,
                                  onTap: () {
                                    if (inputTextCtr.text != "") {
                                      inputTextCtr.selection = TextSelection(
                                          baseOffset: 0,
                                          extentOffset:
                                              inputTextCtr.text.length);
                                    }
                                  },
                                  maxLines: 20,
                                  minLines: 5,
                                  onChanged: (value) {
                                    Timer(Duration(milliseconds: 500), () {
                                      submitTranslation();
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      hintText: "Enter Text",
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      filled: true,
                                      fillColor: Colors.white),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  minLines: 5,
                                  maxLines: 20,
                                  controller: outputTextCtr,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                      hintText: "Translation",
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                              ),
                            ],
                          ),
                          BlocConsumer<TranslationBloc, TranslationState>(
                            listener: (context, state) {
                              if (state is TranslationSuccessState) {
                                print(state.translateModel.last.text);
                                outputTextCtr.text =
                                    state.translateModel.last.text!;
                              }
                              if (state is TranslationErrorState) {
                                print(state.msg.toString());
                              }
                            },
                            builder: (context, state) {
                              return Column(
                                children: [],
                              );
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitTranslation() {
    if (inputTextCtr.text != "") {
      if (currentLanguage != "") {
        if (translationLanguage != "") {
          translationBloc.add(
            SubmitTranslationEvent(
              translateModel: TranslateModel(
                  source_language: currentLanguage,
                  target_language: translationLanguage,
                  text: inputTextCtr.text),
            ),
          );
        }
      }
    }
  }
}
