import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../parsers/news_parser.dart';

class News {
  //todo should we add this class in different folder
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;
  bool isFavorite=false;

  News({
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

  static const List<String> categoryList = [
    'science',
    'business',//todo why we are using category here
    'sports',
  ];

  String category = categoryList[0];

  List<News> get newsList {
    return [..._newsList];
  }

  Future<void> fetchArticlesForCategory() async {
    Dio dio = Dio();
    try {
      //todo we are use category is it correct
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
  }

  String getUrlForCategory(String category) {
    return '$_baseurl?country=us&category=$category&apiKey=$_apiKey';
  }

  Future<void> categoryChangeButtonClick(int index) async {
    category = categoryList[index];
    await fetchArticlesForCategory();
    // notifyListeners();
  }

  void addFavoriteNews(int index){
    bool isfavorite=newsList[index].isFavorite;
    newsList[index].isFavorite=!isfavorite;
    notifyListeners();
  }

  List<News> getFavoriteNews(){
    Iterable<News> news=newsList.where((element) {
      return element.isFavorite==true;
    });
    List<News> favNews=news.map((e)=>e).toList();
    print('this is the favNews length  ${favNews.length}');
    return favNews;
  }
  void removeFavoriteNews(int index){
    List<News> favNews=getFavoriteNews();
    bool isFavoriteImage=favNews[index].isFavorite;
    favNews[index].isFavorite=!isFavoriteImage;
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

class Example{
  Map<String,List<News>>newsMap={};

  List<News> newslist=[];

  void fatchData(String category)async{
    Dio dio=Dio();
    Response response=await dio.get('here we will give the url and category $category');
    List<News>newsList=NewsParser.parseArticles(response.data['articles']);
    if(newsMap.containsKey(category)){
      //suppose our map contain this key
      // then we will compare the data of our map (this key) with this NewsList
      //if data will be different then we will update our map (this key)
      // and if our map (key) is same as this newsList then we will do nothing
      if(newsMap[category]![0].title==newsList[0].title){
        // if first index title is same then there is no change in news
      }
      else{
        // if it comes in else this means our data(news) has changed
        // then we will update our map (key) with this list
        newsMap[category]=newsList;
      }
    }
    else{

      // if this comes in else this means our map doesn't have this key (category)

      // then simply we will add this data(category) in our map
      newsMap.putIfAbsent(category, () => newsList);
    }
    // and in last we will take this category data and save it in our newlist(instance variable)
    // and will will show this list on UI
  }


  // todo PROBLEM :->   suppose user has clicked  favorite button of  1st news (category = sports)
  //todo      :->      and suppose news has updated now and when user will click on favorite button of 1 news
  //todo   :->      this will change the previous favorite news with this one
  void addFavoritenews(int index){
    // suppose sports news are showing on our UI this means
    //          category=sports
    // and user clicks on favorite button of 5th news then  :->
    //todo make a category variable
    bool fav=newsMap['sports']![index].isFavorite;
    //todo 1.  we can update both map and list after favorite button click
    newsMap['sports']![index].isFavorite=!fav;
    newslist[index].isFavorite=!fav;

    //todo 2>  we can ref the list from the map(key)

    newslist=newsMap['category'] as List<News>;

    //todo which one is best

  }
}
