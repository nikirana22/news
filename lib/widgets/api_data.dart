import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/entity/dao_data.dart';
import 'package:provider/provider.dart';
import '../changeconnectivity/change_notifier.dart';
import '../dao/dao.dart';
import '../database/dao_database.dart';
import '../screens/Home.dart';

import '../models/articles.dart';
import '../parsers/news_parser.dart';

//TODO 01/06/2022: Check API if there is an endpoint which can give all
// category data at once so we can filter it later on in app
class ApiData extends StatefulWidget {
  Dao? dao;
  Function onPageChange;
  int position;
  late DaoDatabase data;

  static const String _apiKey = 'a76eab3a9db6401986b50fc441c1ce56';
  static const String _baseurl = 'https://newsapi.org/v2/top-headlines';

  void getDatabaseObj() async {
    data = await $FloorDaoDatabase.databaseBuilder('apidata').build();
    dao = data.datadao;
  }

  ApiData({required this.onPageChange, required this.position}) {
    getDatabaseObj();
  }

  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> with WidgetsBindingObserver {
  // final Dao dao;
  Future<dynamic>? _api;
  Articles? _articles;

  List<DataDao>? lastList;
  // AppLifecycleState? _appLifecycleState;
  static const List<String> _categoryList = [
    'science',
    'business',
    'sports',
  ];
  String _category = _categoryList[0];
  List<Widget>? _pages;
  bool a = false;
  Articles? lastArticle;
  // _ApiDataState({required this.dao});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _api = callApi();
  }

  void getDataa() async {
    List<DataDao> list = await widget.dao!.getData();
    lastArticle =NewsParser.change(list);
    print('database data is getting ${list.length}');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('----------------------------------------------------------');
      _api?.then((value) {
        List list = value['articles'];
        list.map((e) {
          return getMap(e);
        }).toList();
      });
      // dao.addData(dataDao)
    }
  }

  //todo intl.dart date format
  //https://newsapi.org/v2/top-headlines/sources?category=sports&apiKey=a76eab3a9db6401986b50fc441c1ce56
  //https://newsapi.org/v2/top-headlines/sources&apiKey=a76eab3a9db6401986b50fc441c1ce56
  // https://newsapi.org/v2/top-headlines?country=us&category=science&apiKey=a76eab3a9db6401986b50fc441c1ce56
  // Future<void> listdata()async{
  //   lastList=await  widget.dao?.getData() ;
  //   lastArticle=NewsParser.change(lastList!);
  // }
  @override
  Widget build(BuildContext context) {
    // claas >
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: _api,
          //Todo 5/20/2022   change this
          builder: (_, snapshot) {
            if (snapshot.hasData) {
              return _pages![widget.position];
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),


      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        onTap: (ind) => widget.onPageChange(ind),
        currentIndex: widget.position,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: '',
              backgroundColor: Colors.black),
          BottomNavigationBarItem(
              icon: Icon(Icons.notification_add), label: 'Notification'),
          BottomNavigationBarItem(icon: Icon(Icons.save), label: "saved"),
          BottomNavigationBarItem(icon: Icon(Icons.boy), label: "user")
        ],
      ),);
  }



  void categoryChangeButtonClick(int index) {
    setState(() {
      _category = _categoryList[index];
      _api = callApi();
    });
  }

  Future<dynamic> callApi() async {
    Dio dio = Dio();
    Response response = await dio.get(getApi());
    Map map = response.data;
    _articles = NewsParser.parseArticles(map['articles']);
    addPages();
    return response.data;
  }

  String getApi() {
    return '${ApiData._baseurl}?country=us&category=$_category&apiKey=${ApiData._apiKey}';
  }

  void addPages() {
    _pages = [
      Home(
        moreButtonClick: moreButtonClick,
        category: _category,
        categoryList: _categoryList,
        articles: _articles,
        categoryChangeButtonClick: categoryChangeButtonClick,
      ),
      Container(
        color: Colors.white60,
      ),
      Container(
        color: Colors.purple,
      ),
      Container(
        color: Colors.yellow,
      )
    ];
  }

  // void check(){
  //   _api?.then((value) {
  //     List myList=value['articles'];
  //     myList.map((e)  {
  //       getMap(e);
  //     }).toList();
  //   });
  // }
  Map getMap(Map map) {
    DataDao dataDao = DataDao(
        author: map['author'],
        title: map['title'],
        description: map['description'],
        url: map['url'],
        urlToImage: map['urlToImage'],
        publishedAt: map['publishedAt'],
        content: map['content']);
    widget.dao?.addData(dataDao);
    return map;
  }

  void moreButtonClick() {
    print('calling................................');
    getDataa();
  }
// void getData()async{
//   List<DataDao> list=await dao.getData();
//   print(list[0].author);
// }
// @override
// void dispose() {
//   // TODO: implement dispose
//   super.dispose();
//   print('despose method');
// }
}
