import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_api/bloc/stphen_king_books_bloc/stphen_king_books_state.dart';
import 'package:try_api/model/stphen_king_books_model.dart';
import 'package:try_api/repository/stphen_king_books_repo.dart';

import '../bloc/stphen_king_books_bloc/stphen_king_books_bloc.dart';
import '../bloc/stphen_king_books_bloc/stphen_king_books_event.dart';
import '../bloc/stphen_king_villens_bloc/stphen_king_villains_bloc.dart';
import '../bloc/stphen_king_villens_bloc/stphen_king_villains_event.dart';
import '../bloc/stphen_king_villens_bloc/stphen_king_villains_state.dart';


class StphenKingBooksWidget extends StatefulWidget {
  StphenKingBooksWidget({super.key, required this.stphenKingBooksModels});
  StphenKingBooksModels stphenKingBooksModels;

  @override
  State<StphenKingBooksWidget> createState() => _StphenKingBooksWidgetState();
}

class _StphenKingBooksWidgetState extends State<StphenKingBooksWidget>
    with TickerProviderStateMixin {
  bool isExpend = false;
  late AnimationController _controller;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        showBookDetailDialoge(id: widget.stphenKingBooksModels.id!);
      },
      child: Card(
        color: Colors.blue.withGreen(210).withOpacity(0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      "${widget.stphenKingBooksModels.title} (${widget.stphenKingBooksModels.year})",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isExpend = !isExpend;
                      });
                    },
                    icon: Transform.scale(
                      scale: 1,
                      child: isExpend
                          ? Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.keyboard_arrow_up_rounded,
                              color: Colors.white,
                            ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Publisher :",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      "${widget.stphenKingBooksModels.publisher}",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "${widget.stphenKingBooksModels.pages}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              if (widget.stphenKingBooksModels.notes!.join(', ').isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        CupertinoIcons.arrow_turn_down_right,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Text(
                          "${widget.stphenKingBooksModels.notes!.join(', ')}",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              if (widget.stphenKingBooksModels.villains!.isNotEmpty && isExpend)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        "Villains",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      direction: Axis.horizontal,
                      spacing: 10,
                      runSpacing: 10,
                      children: List.generate(
                        widget.stphenKingBooksModels.villains!.length,
                        (index) => InkWell(
                          onTap: () {
                            List<String> parts = widget
                                .stphenKingBooksModels.villains![index].url!
                                .split('/');
                            showBookVillainsDetailDialoge(
                                id: int.tryParse(parts.last)!);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black54),
                            child: Text(
                              "${widget.stphenKingBooksModels.villains![index].name}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  showBookDetailDialoge({required int id}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      
      builder: (context) {
        return BlocProvider(
          create: (context) => StphenKingBooksBloc(StphenKingBooksRepoImpl()),
          child: StatefulBuilder(builder: (context, setState) {
            late StphenKingBooksBloc stphenKingBooksBloc;
            stphenKingBooksBloc = context.read<StphenKingBooksBloc>();
            stphenKingBooksBloc.add(
              FetchStphenKingBooksByIdEvent(id: id),
            );
            _controller = AnimationController(
                vsync: this, duration: Duration(milliseconds: 600));
            return AlertDialog(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              backgroundColor: Colors.transparent,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<StphenKingBooksBloc, StphenKingBooksState>(
                    builder: (context, state) {
                      if (state is StphenKingBooksByIdInitialState ||
                          state is StphenKingBooksByIdLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is StphenKingBooksByIdErrorState) {
                        return Center(
                          child: Text(
                            "${state.msg.toString()}",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      }
                      if (state is StphenKingBooksByIdLoadedState) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  if (_controller.value == 1)
                                    _controller.reverse(from: 1);
                                  else
                                    _controller.forward(from: 0);
                                },
                                child: AnimatedBuilder(
                                  animation: _controller,
                                  builder: (c, anim) => Transform(
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.0025)
                                      ..rotateY(_controller.value * pi),
                                    alignment: FractionalOffset.center,
                                    child: _controller.value < 0.5
                                        ? Container(
                                            height: 250,
                                            width: 250,
                                            child: Card(
                                              color: Colors.white,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      height: 178,
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Column(
                                                          children: [
                                                            Center(
                                                              child: Text(
                                                                "${state.stphenKingBooksModels.title}",
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        18),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Year : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "${state.stphenKingBooksModels.year}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "Publisher : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "${state.stphenKingBooksModels.publisher}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Text(
                                                                  "ISBN : ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    "${state.stphenKingBooksModels.iSBN}",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            if (state
                                                                .stphenKingBooksModels
                                                                .notes!
                                                                .join(', ')
                                                                .isNotEmpty)
                                                              Column(
                                                                children: [
                                                                  RichText(
                                                                    softWrap:
                                                                        true,
                                                                    text:
                                                                        TextSpan(
                                                                      children: [
                                                                        WidgetSpan(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                const EdgeInsets.only(right: 8),
                                                                            child:
                                                                                Icon(
                                                                              CupertinoIcons.arrow_turn_down_right,
                                                                              color: CupertinoColors.black,
                                                                              size: 18,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        TextSpan(
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.black,
                                                                              wordSpacing: 1,
                                                                            ),
                                                                            text:
                                                                                "${state.stphenKingBooksModels.notes!.join(', ')}"),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 10,
                                                                  ),
                                                                ],
                                                              ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Icon(Icons
                                                          .touch_app_outlined),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Transform.scale(
                                            scaleX: -1,
                                            child: Container(
                                              height: 250,
                                              width: 250,
                                              child: Card(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        height: 178,
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Center(
                                                                child: Text(
                                                                  "Villains",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          18),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              Wrap(
                                                                direction: Axis
                                                                    .horizontal,
                                                                alignment:
                                                                    WrapAlignment
                                                                        .start,
                                                                spacing: 10,
                                                                runSpacing: 10,
                                                                children: List
                                                                    .generate(
                                                                  state
                                                                      .stphenKingBooksModels
                                                                      .villains!
                                                                      .length,
                                                                  (index) =>
                                                                      InkWell(
                                                                    onTap: () {
                                                                      List<String> parts = state
                                                                          .stphenKingBooksModels
                                                                          .villains![
                                                                              index]
                                                                          .url!
                                                                          .split(
                                                                              '/');
                                                                      showBookVillainsDetailDialoge(
                                                                          id: int.tryParse(
                                                                              parts.last)!);
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      padding: EdgeInsets.symmetric(
                                                                          horizontal:
                                                                              15,
                                                                          vertical:
                                                                              5),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          color:
                                                                              Colors.blueGrey),
                                                                      child:
                                                                          Text(
                                                                        "${state.stphenKingBooksModels.villains![index].name}",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Icon(Icons
                                                            .touch_app_outlined),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.blue,
                                ))
                          ],
                        );
                      }
                      return Center(
                        child: Text(
                            "Something want wrong, please connect with developer"),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }

  showBookVillainsDetailDialoge({required int id}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return BlocProvider(
          create: (context) =>
              StphenKingVillainsBloc(StphenKingBooksRepoImpl()),
          child: StatefulBuilder(builder: (context, setState) {
            late StphenKingVillainsBloc stphenKingVillainsBloc;
            stphenKingVillainsBloc = context.read<StphenKingVillainsBloc>();
            stphenKingVillainsBloc.add(FetchStphenKingVillainByIdEvent(
              id: id,
            ));
            _controller = AnimationController(
                vsync: this, duration: Duration(milliseconds: 600));
            return AlertDialog(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              backgroundColor: Colors.transparent,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<StphenKingVillainsBloc, StphenKingVillainsState>(
                    builder: (context, state) {
                      if (state is StphenKingVillainsInitialState ||
                          state is StphenKingVillainsLoadingState) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (state is StphenKingVillainsNoDataState) {
                        return Center(
                          child: Text("No Data Found"),
                        );
                      }
                      if (state is StphenKingVillainsNoInternetState) {
                        return Center(
                          child: Text("No Internet"),
                        );
                      }
                      if (state is StphenKingVillainsErrorState) {
                        return Center(
                          child: Text("${state.msg.toString()}"),
                        );
                      }
                      if (state is StphenKingVillainsLoadedState) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Container(
                                  constraints: BoxConstraints(
                                      minHeight: 0, maxHeight: 400),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Text(
                                            "${state.stphenKingBookVillainModel.name}",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Gender : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${state.stphenKingBookVillainModel.gender}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Status : ",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            Expanded(
                                              child: Text(
                                                "${state.stphenKingBookVillainModel.status}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (state.stphenKingBookVillainModel
                                                .notes!.length >
                                            0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  "Notes",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Wrap(
                                                direction: Axis.horizontal,
                                                alignment: WrapAlignment.start,
                                                spacing: 10,
                                                runSpacing: 10,
                                                children: List.generate(
                                                  state
                                                      .stphenKingBookVillainModel
                                                      .notes!
                                                      .length,
                                                  (index) => Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.blueGrey),
                                                    child: Text(
                                                      "${state.stphenKingBookVillainModel.notes?[index]}",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        if (state.stphenKingBookVillainModel
                                                .books!.length >
                                            0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  "Books",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Wrap(
                                                direction: Axis.horizontal,
                                                alignment: WrapAlignment.start,
                                                spacing: 10,
                                                runSpacing: 10,
                                                children: List.generate(
                                                  state
                                                      .stphenKingBookVillainModel
                                                      .books!
                                                      .length,
                                                  (index) => InkWell(
                                                    onTap: () {
                                                      List<String>? parts = state
                                                          .stphenKingBookVillainModel
                                                          .books?[index]
                                                          .url!
                                                          .split('/');
                                                      showBookDetailDialoge(
                                                          id: int.tryParse(
                                                              parts!.last)!);
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15,
                                                              vertical: 5),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          color:
                                                              Colors.blueGrey),
                                                      child: Text(
                                                        "${state.stphenKingBookVillainModel.books?[index].title}",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                        if (state.stphenKingBookVillainModel
                                                .shorts!.length >
                                            0)
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Text(
                                                  "Shorts",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 16),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Wrap(
                                                direction: Axis.horizontal,
                                                alignment: WrapAlignment.start,
                                                spacing: 10,
                                                runSpacing: 10,
                                                children: List.generate(
                                                  state
                                                      .stphenKingBookVillainModel
                                                      .shorts!
                                                      .length,
                                                  (index) => Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 15,
                                                            vertical: 5),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: Colors.blueGrey),
                                                    child: Text(
                                                      "${state.stphenKingBookVillainModel.shorts?[index].title}",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStatePropertyAll(Colors.white)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.blue,
                                ))
                          ],
                        );
                      }
                      return Center(
                        child: Text(
                            "Something want wrong, Please connect with developer"),
                      );
                    },
                  )
                ],
              ),
            );
          }),
        );
      },
    );
  }
}
