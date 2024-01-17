// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:rapid_apis/bloc/stphen_king_villens_bloc/stphen_king_villains_bloc.dart';
// import 'package:rapid_apis/bloc/stphen_king_villens_bloc/stphen_king_villains_event.dart';
// import 'package:rapid_apis/bloc/stphen_king_villens_bloc/stphen_king_villains_state.dart';

// class StphenKingBookDetailScreen extends StatefulWidget {
//   StphenKingBookDetailScreen({super.key});

//   @override
//   State<StphenKingBookDetailScreen> createState() =>
//       _StphenKingBookDetailScreenState();
// }

// class _StphenKingBookDetailScreenState
//     extends State<StphenKingBookDetailScreen> {
//   late StphenKingVillainsBloc stphenKingVillainsBloc;

//   @override
//   void initState() {
//     stphenKingVillainsBloc = context.read<StphenKingVillainsBloc>();
    
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: BlocBuilder<StphenKingVillainsBloc, StphenKingVillainsState>(
//           builder: (context, state) {
//             if (state is StphenKingVillainsInitialState ||
//                 state is StphenKingVillainsLoadingState) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             if (state is StphenKingVillainsNoDataState) {
//               return Center(
//                 child: Text("No Data Found"),
//               );
//             }
//             if (state is StphenKingVillainsNoInternetState) {
//               return Center(
//                 child: Text("No Internet"),
//               );
//             }
//             if (state is StphenKingVillainsErrorState) {
//               return Center(
//                 child: Text("${state.msg.toString()}"),
//               );
//             }
//             if (state is StphenKingVillainsLoadedState) {
//               return Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 10, top: 10),
//                     child: InkWell(
//                       splashFactory: NoSplash.splashFactory,
//                       highlightColor: Colors.transparent,
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Card(
//                         color: Colors.white,
//                         child: SizedBox(
//                           height: 45,
//                           width: 45,
//                           child: Icon(
//                             Icons.arrow_back,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Card(
//                     color: Colors.white,
//                     child: Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Container(
//                         child: SingleChildScrollView(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Center(
//                                 child: Text(
//                                   "${state.stphenKingBookVillainModel.name}",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w500,
//                                       fontSize: 18),
//                                   textAlign: TextAlign.center,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Gender : ",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 16),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       "${state.stphenKingBookVillainModel.gender}",
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 16),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Status : ",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontWeight: FontWeight.w500,
//                                         fontSize: 16),
//                                   ),
//                                   Expanded(
//                                     child: Text(
//                                       "${state.stphenKingBookVillainModel.status}",
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.w500,
//                                           fontSize: 16),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               if (state.stphenKingBookVillainModel.notes!
//                                       .length >
//                                   0)
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 15),
//                                       child: Text(
//                                         "Notes",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 16),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Wrap(
//                                       direction: Axis.horizontal,
//                                       alignment: WrapAlignment.start,
//                                       spacing: 10,
//                                       runSpacing: 10,
//                                       children: List.generate(
//                                         state.stphenKingBookVillainModel.notes!
//                                             .length,
//                                         (index) => Container(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 15, vertical: 5),
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               color: Colors.blueGrey),
//                                           child: Text(
//                                             "${state.stphenKingBookVillainModel.notes?[index]}",
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 ),
//                               if (state.stphenKingBookVillainModel.books!
//                                       .length >
//                                   0)
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 15),
//                                       child: Text(
//                                         "Books",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 16),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Wrap(
//                                       direction: Axis.horizontal,
//                                       alignment: WrapAlignment.start,
//                                       spacing: 10,
//                                       runSpacing: 10,
//                                       children: List.generate(
//                                         state.stphenKingBookVillainModel.books!
//                                             .length,
//                                         (index) => Container(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 15, vertical: 5),
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               color: Colors.blueGrey),
//                                           child: Text(
//                                             "${state.stphenKingBookVillainModel.books?[index]}",
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 ),
//                               if (state.stphenKingBookVillainModel.shorts!
//                                       .length >
//                                   0)
//                                 Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       height: 20,
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 15),
//                                       child: Text(
//                                         "Shorts",
//                                         style: TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                             fontSize: 16),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                     Wrap(
//                                       direction: Axis.horizontal,
//                                       alignment: WrapAlignment.start,
//                                       spacing: 10,
//                                       runSpacing: 10,
//                                       children: List.generate(
//                                         state.stphenKingBookVillainModel.shorts!
//                                             .length,
//                                         (index) => Container(
//                                           padding: EdgeInsets.symmetric(
//                                               horizontal: 15, vertical: 5),
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(10),
//                                               color: Colors.blueGrey),
//                                           child: Text(
//                                             "${state.stphenKingBookVillainModel.shorts?[index].title}",
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               );
//             }
//             return Center(
//               child:
//                   Text("Something want wrong, Please connect with developer"),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
