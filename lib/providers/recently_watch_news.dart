import 'package:flutter/material.dart';
import 'news.dart';

class RecentlyWatchNews with ChangeNotifier{
  List<News> recentlyWatchNews =[];
  int newsLength=0;
  void addRecentlyWatchNews(News news) {
    recentlyWatchNews.add(news);
    newsLength=recentlyWatchNews.length;
    // notifyListeners();
  }
  List<News> getRecentlyWatchNews(){
    // notifyListeners();
    return recentlyWatchNews;
  }

}