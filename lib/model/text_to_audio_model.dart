class TextToAudioModel {
  String? voice_code;
  String? text;
  String? speed;
  String? pitch;
  String? output_type;
  

  TextToAudioModel({
    required this.voice_code,
    required this.text,
    required this.speed,
    required this.pitch,
    required this.output_type,
  });

  TextToAudioModel.fromJson(Map<String, dynamic> json) {
    voice_code = json['voice_code'];
    text = json['text'];
    speed = json['speed'];
    pitch = json[pitch];
    output_type = json['output_type'];
  }
  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['voice_code'] = this.voice_code;
    data['text'] = this.text;
    data['speed'] = this.speed;
    data['pitch'] = this.pitch;
    data['output_type'] = this.output_type;
    return data;
  }
}
