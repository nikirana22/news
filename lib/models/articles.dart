import '../models/news.dart';

class Articles {
  List<News>? _newsList;

  List<News> get newsList {
    return [...?_newsList];
  }

  set setNewsList(List<News> newsList) {
    _newsList = newsList;
  }
}
