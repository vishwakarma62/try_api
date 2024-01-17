class TranslateModel {
  String? source_language;
  String? target_language;
  String? text;

  TranslateModel(
      {this.source_language, this.target_language, this.text});

  TranslateModel.fromJson(Map<String, dynamic> json) {
    source_language = json['source_language'];
    target_language = json['target_language'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source_language'] = this.source_language;
    data['target_language'] = this.target_language;
    data['text'] = this.text;
    return data;
  }
}