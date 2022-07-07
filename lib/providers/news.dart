import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../parsers/news_parser.dart';

class News {
  //todo should we add this class in different folder
  int id;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  bool isFavorite = false;

  News(
      {required this.id,
      required this.author,
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
  List<News> favoriteNews = [];

  static const List<String> categoryList = [
    'science',
    'business', //todo why we are using category here
    'sports',
  ];

  String category = categoryList[0];
  List<News> get newsList {
    return [..._newsList];
  }

  Future<void> fetchArticlesForCategory() async {
    Dio dio = Dio();
    try {
      //todo we are using category is it correct
      Response response = await dio.get(getUrlForCategory(category));
      Map<String, Object> map = response.data;
      setArticles(NewsParser.parseArticles(map['articles'] as List, category));
    } on SocketException {
      print('Something is wrong with internet');
    } catch (error) {
      print('catch statement');
      rethrow;
    }
  }

  void setArticles(List<News> newsList) {
    _newsList = newsList;
  }

  String getUrlForCategory(String category) {
    return '$_baseurl?country=us&category=$category&apiKey=$_apiKey';
  }

  Future<void> categoryChangeButtonClick(int index) async {
    category = categoryList[index];
    await fetchArticlesForCategory();
  }

  void addFavoriteNews(News news) {
    news.isFavorite = true;
    favoriteNews.add(news);
    notifyListeners();
  }

  List<News> getFavoriteNews() {
    Iterable<News> news = newsList.where((element) {
      return element.isFavorite == true;
    });
    List<News> favNews = news.map((e) => e).toList();
    print('this is the favNews length  ${favNews.length}');
    return favNews;
  }

  // void removeFavoriteNews(int index){
  //   List<News> favNews=getFavoriteNews();
  //   bool isFavoriteImage=favNews[index].isFavorite;
  //   favNews[index].isFavorite=!isFavoriteImage;
  //   notifyListeners();
  // }

  void removeFavoriteNews(int id) {
    favoriteNews.removeWhere((element) => element.id==id);
    //todo this method is doing too much work
    NewsParser.removeFavorite(id);
    notifyListeners();
  }

// Future<List<News>> fetchData(BuildContext context) async {//todo is this correct
//   var connectivityCheck=await Connectivity().checkConnectivity();
//   if (connectivityCheck == ConnectivityResult.wifi ||
//       connectivityCheck == ConnectivityResult.mobile) {
//     Articles articles = Provider.of<Articles>(context, listen: false);
//     await articles.fetchArticlesForCategory();
//     // setState(() {
//       return articles.newsList;
//       _isOnline=true;
//     // });
//   } else if(connectivityCheck==ConnectivityResult.none){/*if db has items*/
//     DatabaseProvider databaseProvider=Provider.of<DatabaseProvider>(context,listen: false);
//     await databaseProvider.getDataFromDatabase();
//     // setState(() {
//       return databaseProvider.articlesDatabase;
//       _isOnline=false;
//     // });
//   }
//   else{
//     return [];
//   }
// }

}
