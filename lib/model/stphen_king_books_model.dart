class StphenKingBooksModels {
  int? id;
  int? year;
  String? title;
  String? handle;
  String? publisher;
  String? iSBN;
  int? pages;
  List<String>? notes;
  String? createdAt;
  List<Villains>? villains;

  StphenKingBooksModels(
      {this.id,
      this.year,
      this.title,
      this.handle,
      this.publisher,
      this.iSBN,
      this.pages,
      this.notes,
      this.createdAt,
      this.villains});

  StphenKingBooksModels.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    year = json['Year'];
    title = json['Title'];
    handle = json['handle'];
    publisher = json['Publisher'];
    iSBN = json['ISBN'];
    pages = json['Pages'];
    notes = json['Notes'].cast<String>();
    createdAt = json['created_at'];
    if (json['villains'] != null) {
      villains = <Villains>[];
      json['villains'].forEach((v) {
        villains!.add(new Villains.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['Year'] = this.year;
    data['Title'] = this.title;
    data['handle'] = this.handle;
    data['Publisher'] = this.publisher;
    data['ISBN'] = this.iSBN;
    data['Pages'] = this.pages;
    data['Notes'] = this.notes;
    data['created_at'] = this.createdAt;
    if (this.villains != null) {
      data['villains'] = this.villains!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Villains {
  String? name;
  String? url;

  Villains({this.name, this.url});

  Villains.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}