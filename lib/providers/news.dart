import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../parsers/news_parser.dart';

class News {
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  News(
      {required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

}

class Articles with ChangeNotifier {
  static const String _apiKey = 'a76eab3a9db6401986b50fc441c1ce56';
  static const String _baseurl = 'https://newsapi.org/v2/top-headlines';
  List<News> _newsList = [];

  static const List<String> categoryList = [
    'science',
    'business',
    'sports',
  ];

  String category = categoryList[0];

  List<News> get newsList {
    return [..._newsList];
  }

  set setNewsList(List<News> newsList) {
    _newsList = newsList;
  }

  Future<void> fetchArticlesForCategory() async {
    Dio dio = Dio();
    try {
      Response response = await dio.get(getUrlForCategory(category));
      Map<String, Object> map = response.data;
      setArticles(NewsParser.parseArticles(map['articles'] as List));
    } on SocketException {
      print('Something is wrong with internet');
    } catch (error) {
      print('catch statement');
      rethrow;
    }
  }

  void setArticles(List<News> newsList) {
    _newsList = newsList;
    notifyListeners();
  }

  String getUrlForCategory(String category) {
    return '$_baseurl?country=us&category=$category&apiKey=$_apiKey';
  }

  void categoryChangeButtonClick(int index) {
    category = categoryList[index];
    notifyListeners();
  }
}
