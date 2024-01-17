import 'package:equatable/equatable.dart';

abstract class StphenKingVillainsEvent extends Equatable {}

class FetchStphenKingVillainsEvent extends StphenKingVillainsEvent {
  @override
  List<Object?> get props => [];
}

class FetchStphenKingVillainByIdEvent extends StphenKingVillainsEvent {
  int id;
  FetchStphenKingVillainByIdEvent({required this.id});
  @override
  List<Object?> get props => [id];
}
