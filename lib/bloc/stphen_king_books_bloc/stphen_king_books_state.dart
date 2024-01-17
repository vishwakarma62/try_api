import 'package:equatable/equatable.dart';
import 'package:try_api/model/stphen_king_books_model.dart';

abstract class StphenKingBooksState extends Equatable {}

// Stphen King Books

class StphenKingBooksInitialState extends StphenKingBooksState {
  @override
  List<Object?> get props => [];
}

class StphenKingBooksLoadingState extends StphenKingBooksState {
  @override
  List<Object?> get props => [];
}

class StphenKingBooksNoInternetState extends StphenKingBooksState {
  @override
  List<Object?> get props => [];
}

class StphenKingBooksNoDataState extends StphenKingBooksState {
  @override
  List<Object?> get props => [];
}

class StphenKingBooksLoadedState extends StphenKingBooksState {
  List<StphenKingBooksModels> stphenKingBooksModels;
  StphenKingBooksLoadedState({required this.stphenKingBooksModels});
  @override
  List<Object?> get props => [stphenKingBooksModels];
}

class StphenKingBooksErrorState extends StphenKingBooksState {
  String msg;
  StphenKingBooksErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
}

// Stphen King Books

class StphenKingBooksByIdInitialState extends StphenKingBooksState {
  @override
  List<Object?> get props => [];
}

class StphenKingBooksByIdLoadingState extends StphenKingBooksState {
  @override
  List<Object?> get props => [];
}

class StphenKingBooksByIdNoInternetState extends StphenKingBooksState {
  @override
  List<Object?> get props => [];
}

class StphenKingBooksByIdNoDataState extends StphenKingBooksState {
  @override
  List<Object?> get props => [];
}

class StphenKingBooksByIdLoadedState extends StphenKingBooksState {
  StphenKingBooksModels stphenKingBooksModels;
  StphenKingBooksByIdLoadedState({required this.stphenKingBooksModels});
  @override
  List<Object?> get props => [];
}

class StphenKingBooksByIdErrorState extends StphenKingBooksState {
  String msg;
  StphenKingBooksByIdErrorState({required this.msg});
  @override
  List<Object?> get props => [msg];
}
