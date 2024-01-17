import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/text_to_audio_bloc/text_to_audio_bloc.dart';
import '../../bloc/text_to_audio_bloc/text_to_audio_event.dart';
import '../../bloc/text_to_audio_bloc/text_to_audio_state.dart';

class TextToAudioScreen extends StatefulWidget {
  const TextToAudioScreen({super.key});

  @override
  State<TextToAudioScreen> createState() => _TextToAudioScreenState();
}

class _TextToAudioScreenState extends State<TextToAudioScreen> {
  String dropdownvalue1 = "-- Select --";
  String dropdownvalue2 = "Select Voice";
  List countryData = [];
  List countryData2 = [];
  String langCode = "";

  bool isLoading = false;

  late TextToAudioBloc textToAudioBloc;
  @override
  void initState() {
    super.initState();
    textToAudioBloc = context.read<TextToAudioBloc>();
    textToAudioBloc.add(FetchAudioLanguage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Text To Voice",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              BlocListener<TextToAudioBloc, TextToAudioState>(
                listener: (context, state) {
                  if (state is TextToAudioGetLanguageLoadingState) {
                    setState(() {
                      isLoading = true;
                    });
                  }
                  if (state is TextToAudioGetLanguageLoadedState) {
                    setState(() {
                      countryData = state.languageAudioModel;
                    });
                  }
                  if (state is TextToAudioGetAudioLoadedState) {
                    setState(() {
                      countryData2 = state.textVoiceModel;
                      isLoading = false;
                    });
                    showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                  content: Container(
                                constraints: BoxConstraints(maxHeight: 300),
                                child: ListView.separated(
                                  padding: EdgeInsets.only(top: 10),
                                  shrinkWrap: true,
                                  itemCount: countryData2.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Language ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  ":  ${countryData2[index].languageName}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Type",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  ":  ${countryData2[index].voiceType}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                flex: 1,
                                                child: Text(
                                                  "Gender",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Text(
                                                  ":  ${countryData2[index].voiceGender}",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    height: 10,
                                  ),
                                ),
                              )),
                            );
                  }
                },
                child: Row(
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
                          child: Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${dropdownvalue1}",
                                    style: TextStyle(color: Colors.white),
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
                              FocusManager.instance.primaryFocus!.unfocus();
                              setState(() {
                                dropdownvalue1 = countryData[index].name;
                                langCode = countryData[index].code;
                              });
                            },
                            child: Text(
                              countryData[index].name,
                            ),
                          ),
                        ),
                      ),
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
                      child: InkWell(
                        onTap: () async {
                          if (langCode != "") {
                            textToAudioBloc
                                .add(FetchAudioEvent(langCode: langCode));
                          } else {
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
                                    "Please select the language",
                                    style: TextStyle(color: Colors.red[400]),
                                  ),
                                ),
                              ),
                            ));
                          }
                        },
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "${dropdownvalue2}",
                                    style: TextStyle(color: Colors.white),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      // PopupMenuButton(
                      //   tooltip: "",
                      //   child: Container(
                      //     padding: const EdgeInsets.symmetric(
                      //       horizontal: 10,
                      //       vertical: 5,
                      //     ),
                      //     decoration: BoxDecoration(
                      //       border: Border.all(
                      //         color: Colors.blue,
                      //       ),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Center(
                      //       child: SingleChildScrollView(
                      //         scrollDirection: Axis.horizontal,
                      //         child: Row(
                      //           mainAxisAlignment: MainAxisAlignment.center,
                      //           crossAxisAlignment: CrossAxisAlignment.center,
                      //           mainAxisSize: MainAxisSize.min,
                      //           children: [
                      //             Text(
                      //               "${dropdownvalue2}",
                      //               style: TextStyle(color: Colors.white),
                      //               overflow: TextOverflow.ellipsis,
                      //             ),

                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      //   itemBuilder: (context) => List.generate(
                      //     countryData2.length,
                      //     (index) => PopupMenuItem(
                      //       onTap: () {
                      //         FocusManager.instance.primaryFocus!.unfocus();
                      //         setState(() {
                      //           dropdownvalue2 = countryData2[index].languageName;
                      //         });
                      //       },
                      //       child: Container(
                      //         color: Colors.yellow,
                      //         child: Column(
                      //           children: [
                      //             Text(
                      //               countryData2[index].languageName,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
