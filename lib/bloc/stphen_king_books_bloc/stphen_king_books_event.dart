import 'package:equatable/equatable.dart';

abstract class StphenKingBooksEvent extends Equatable {}

class FetchStphenKingBooksEvent extends StphenKingBooksEvent {
  @override
  List<Object?> get props => [];
}

class FetchStphenKingBooksByIdEvent extends StphenKingBooksEvent {
  int id;
  FetchStphenKingBooksByIdEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
