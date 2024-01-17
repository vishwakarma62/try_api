import 'package:equatable/equatable.dart';
import 'package:try_api/model/stphen_king_book_villain_model.dart';

abstract class StphenKingVillainsState extends Equatable {}

class StphenKingVillainsInitialState extends StphenKingVillainsState {
  @override
  List<Object?> get props => [];
}

class StphenKingVillainsLoadingState extends StphenKingVillainsState {
  @override
  List<Object?> get props => [];
}

class StphenKingVillainsNoInternetState extends StphenKingVillainsState {
  @override
  List<Object?> get props => [];
}

class StphenKingVillainsNoDataState extends StphenKingVillainsState {
  @override
  List<Object?> get props => [];
}

class StphenKingVillainsLoadedState extends StphenKingVillainsState {
  StphenKingBookVillainModel stphenKingBookVillainModel;
  StphenKingVillainsLoadedState({required this.stphenKingBookVillainModel});

  @override
  List<Object?> get props => [stphenKingBookVillainModel];
}

class StphenKingVillainsErrorState extends StphenKingVillainsState {
  String msg;
  StphenKingVillainsErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
}
