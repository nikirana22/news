import 'package:flutter/cupertino.dart';
import 'package:news/models/news.dart';

class Providerr extends ChangeNotifier{
  List<News>? list=[];
  int bottomNavIndex=0;
  void changemap(News map){
    list?.add(map);
    print('length of my provider list is ${list?.length}');

  }
  int changeIndex(int index){
    bottomNavIndex=index;
    notifyListeners();
    print('myProvider');    return bottomNavIndex;
  }
}