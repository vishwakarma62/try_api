// class LanguageModel {
//   Data? data;
//   LanguageModel({this.data});
//   LanguageModel.fromJson(Map<String, dynamic> json) {
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }
// class Data {
//   List<Languages>? languages;
//   Data({this.languages});
//   Data.fromJson(Map<String, dynamic> json) {
//     if (json['languages'] != null) {
//       languages = <Languages>[];
//       json['languages'].forEach((v) {
//         languages!.add(new Languages.fromJson(v));
//       });
//     }
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.languages != null) {
//       data['languages'] = this.languages!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class LanguageModel {
  String? code;
  String? name;

  LanguageModel({this.code, this.name});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['name'] = this.name;
    return data;
  }
}

class LanguageAudioModel {
  String? code;
  String? name;

  LanguageAudioModel({this.code, this.name});

  LanguageAudioModel.fromJson(Map<String, dynamic> json) {
    code = json['language_code'];
    name = json['language_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language_code'] = this.code;
    data['language_name'] = this.name;
    return data;
  }
}