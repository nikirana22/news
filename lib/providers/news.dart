import 'dart:io';
import 'dart:js';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../parsers/news_parser.dart';
import 'database_provider.dart';

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

  bool? _isOnline;

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

  //
  // List<News> connectivityCheck(BuildContext context)async {
  //   DatabaseProvider databaseProvider=Provider.of<DatabaseProvider>(context,listen: false);
  //   var connectivityCheck=await Connectivity().checkConnectivity();
  //   if (connectivityCheck == ConnectivityResult.wifi ||
  //       connectivityCheck == ConnectivityResult.mobile) {
  //     await fetchArticlesForCategory();
  //       return newsList;
  //   } else if(connectivityCheck==ConnectivityResult.none){/*if db has items*/
  //     await databaseProvider.getDataFromDatabase();
  //       _newList=databaseProvider.articlesDatabase;
  //       _isOnline=false;
  //     });
  //   }
  //
  // }

}
