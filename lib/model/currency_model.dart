class CurrencyModel {
  String? from;
  String? to;
  String? q;
  CurrencyModel({
    required this.from,
    required this.to,
    required this.q,
  });
  CurrencyModel.fromJson(Map<String, dynamic> json) {
    from = json['from'];
    to = json['to'];
    q = json['q'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from'] = this.from;
    data['to'] = this.to;
    data['q'] = this.q;
    return data;
  }
}
