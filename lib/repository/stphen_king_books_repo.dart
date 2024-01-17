import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:try_api/config/constant.dart';
import 'package:try_api/model/stphen_king_books_model.dart';

import '../model/stphen_king_book_villain_model.dart';


abstract class StphenKingBooksRepo {
  Future<List<dynamic>> getStphenKingBooks();
  Future<StphenKingBooksModels> getStphenKingBooksById({required int id});
  Future<StphenKingBookVillainModel> getStphenKingVillainsById({required int id});
}

class StphenKingBooksRepoImpl extends StphenKingBooksRepo {
  Future<List<dynamic>> getStphenKingBooks() async {
    String url = ApiConstant.STPHEN_KING_BOOKS;
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      List<dynamic> body = jsonData['data'];
      return List<StphenKingBooksModels>.from(
          (body).map((e) => StphenKingBooksModels.fromJson(e)));
    } else {
      throw response.body;
    }
  }

  Future<StphenKingBooksModels> getStphenKingBooksById(
      {required int id}) async {
    String url = ApiConstant.STPHEN_KING_BOOK_BY_ID + "$id";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      StphenKingBooksModels body =
          StphenKingBooksModels.fromJson(jsonData['data']);
      return body;
    } else {
      throw response.body;
    }
  }

  Future<StphenKingBookVillainModel> getStphenKingVillainsById(
      {required int  id}) async {
    String url = ApiConstant.STPHEN_KING_VILLAIN_BY_ID + "$id";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = jsonDecode(response.body);
      StphenKingBookVillainModel data =
          StphenKingBookVillainModel.fromJson(jsonData['data']);
      return data;
    } else {
      throw response.body;
    }
  }
}
