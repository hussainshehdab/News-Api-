import 'package:news_app_apis/repository/news_repository.dart';

import '../model/headline_model.dart';
import '../model/lengthy_newa_model,dart';

class NewsVeiwModel {
  Future<NewsHeadlineModel> getapi() async {
    final _res = NewsRepository();
    final response = await _res.getapi();
    return response;
  }

  Future<NewsLengthModel> fetchNewsApi(String category) async {
    final _res = NewsRepository();
    final response = await _res.fetchNewsApi(category);
    return response;
  }
}
