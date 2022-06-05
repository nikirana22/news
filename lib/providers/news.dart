import 'dart:convert';

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

  @override
  String toString() {
    // TODO: implement toString
    return 'author : $author ,title : $title, description : $description , url: $url';
  }

  Map<String, Object> toMap() {
    return {
      NewsParser.authorKey: (author ?? ''),
      NewsParser.title: (title ?? ''),
      NewsParser.description: (description ?? ''),
      NewsParser.url: (url ?? ''),
      NewsParser.urlToImage: (urlToImage ?? ''),
      NewsParser.publishedAt: (publishedAt ?? ''),
      NewsParser.content: (content ?? ''),
    };
  }
}

class Articles with ChangeNotifier {
  static const String _apiKey = 'a76eab3a9db6401986b50fc441c1ce56';
  static const String _baseurl = 'https://newsapi.org/v2/top-headlines';

  List<News> _newsList = [];

  List<News> get newsList {
    return [..._newsList];
  }

  set setNewsList(List<News> newsList) {
    _newsList = newsList;
  }

  Future<void> fetchArticlesForCategory(String category) async {
    Dio dio = Dio();
    Response response = await dio.get(getUrlForCategory(category));
    Map<String, dynamic> map = json.decode(response.data);
    setArticles(NewsParser.parseArticles(map['articles']));
  }

  void setArticles(List<News> newsList) {
    _newsList = newsList;
    notifyListeners();
  }

  String getUrlForCategory(String category) {
    return '$_baseurl?country=us&category=$category&apiKey=$_apiKey';
  }
}
