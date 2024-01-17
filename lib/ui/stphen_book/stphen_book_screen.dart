import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:try_api/bloc/stphen_king_books_bloc/stphen_king_books_bloc.dart';

import '../../bloc/stphen_king_books_bloc/stphen_king_books_event.dart';
import '../../bloc/stphen_king_books_bloc/stphen_king_books_state.dart';
import '../../widget/stphen_king_books_widget.dart';


class StphenBookScreen extends StatefulWidget {
  const StphenBookScreen({super.key});

  @override
  State<StphenBookScreen> createState() => _StphenBookScreenState();
}

class _StphenBookScreenState extends State<StphenBookScreen> {
  late StphenKingBooksBloc stphenKingBooksBloc;
  @override
  void initState() {
    super.initState();
    stphenKingBooksBloc = context.read<StphenKingBooksBloc>();
    stphenKingBooksBloc.add(FetchStphenKingBooksEvent());
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
          "Stphen King books",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
          child: BlocBuilder<StphenKingBooksBloc, StphenKingBooksState>(
        builder: (context, state) {
          if (state is StphenKingBooksInitialState ||
              state is StphenKingBooksLoadingState) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.white,
              
            ));
          }
          if (state is StphenKingBooksErrorState) {
            print(state.msg.toString());
          }
          if (state is StphenKingBooksLoadedState) {
            return SingleChildScrollView(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                primary: false,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return StphenKingBooksWidget(
                    stphenKingBooksModels: state.stphenKingBooksModels[index],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                itemCount: state.stphenKingBooksModels.length,
              ),
            );
          }
          return Center(
            child: Text("Something want wrong"),
          );
        },
      )),
    );
  }
}
