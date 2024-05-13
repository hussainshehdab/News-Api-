import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/headline_model.dart';
import '../model/lengthy_newa_model,dart';

class NewsRepository {
  Future<NewsHeadlineModel> getapi() async {
    String url =
        'https://newsapi.org/v2/top-headlines?country=us&apiKey=641ad32834f3456b995ecf1b9bf43e33';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadlineModel.fromJson(body);
    }
    throw Exception('errror');
  }

  Future<NewsLengthModel> fetchNewsApi(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=${category}&apiKey=641ad32834f3456b995ecf1b9bf43e33';
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsLengthModel.fromJson(body);
    }
    throw Exception('errror');
  }
}
