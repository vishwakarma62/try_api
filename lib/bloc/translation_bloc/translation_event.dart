import 'package:equatable/equatable.dart';
import 'package:try_api/model/translate_model.dart';

abstract class TranslationEvent extends Equatable {}

class SubmitTranslationEvent extends TranslationEvent{
  TranslateModel translateModel;
  SubmitTranslationEvent({required this.translateModel});
  @override
  List<Object?> get props=> [translateModel];  
}