class TextToAudioResponseModel {
  String? status;
  Result? result;

  TextToAudioResponseModel(a, {this.status, this.result});

  TextToAudioResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
        json['result'] != null ? new Result.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    return data;
  }
}

class Result {
  String? audioUrl;

  Result({this.audioUrl});

  Result.fromJson(Map<String, dynamic> json) {
    audioUrl = json['audio_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audio_url'] = this.audioUrl;
    return data;
  }
}
