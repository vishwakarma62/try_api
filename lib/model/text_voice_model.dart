
class TextVoiceModel {
  String? languageCode;
  String? languageName;
  String? voiceType;
  String? voiceCode;
  String? voiceGender;

  TextVoiceModel({
    this.languageCode,
    this.languageName,
    this.voiceType,
    this.voiceCode,
    this.voiceGender,
  });

  TextVoiceModel.fromJson(Map<String, dynamic> json) {
    languageCode = json['language_code'];
    languageName = json['language_name'];
    voiceType = json['voice_type'];
    voiceCode = json['voice_code'];
    voiceGender = json['voice_gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language_code'] = languageCode;
    data['language_name'] = languageName;
    data['voice_type'] = voiceType;
    data['voice_code'] = voiceCode;
    data['voice_gender'] = voiceGender;
    return data;
  }
}
