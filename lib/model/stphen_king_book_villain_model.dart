

class StphenKingBookVillainModel {
  int? id;
  String? name;
  String? gender;
  String? status;
  int? typesId;
  List<String>? notes;
  String? createdAt;
  List<Books>? books;
  List<Books>? shorts;

  StphenKingBookVillainModel(
      {this.id,
      this.name,
      this.gender,
      this.status,
      this.typesId,
      this.notes,
      this.createdAt,
      this.books,
      this.shorts});

  StphenKingBookVillainModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    gender = json['gender'];
    status = json['status'];
    typesId = json['types_id'];
    notes = json['notes'].cast<String>();
    createdAt = json['created_at'];
    if (json['books'] != null) {
      books = <Books>[];
      json['books'].forEach((v) {
        books!.add(new Books.fromJson(v));
      });
    }
    if (json['shorts'] != null) {
      shorts = <Books>[];
      json['shorts'].forEach((v) {
        shorts!.add(new Books.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['status'] = this.status;
    data['types_id'] = this.typesId;
    data['notes'] = this.notes;
    data['created_at'] = this.createdAt;
    if (this.books != null) {
      data['books'] = this.books!.map((v) => v.toJson()).toList();
    }
    if (this.shorts != null) {
      data['shorts'] = this.shorts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Books {
  String? title;
  String? url;

  Books({this.title, this.url});

  Books.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['url'] = this.url;
    return data;
  }
}
