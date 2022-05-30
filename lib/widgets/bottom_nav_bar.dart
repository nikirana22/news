import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/screens/Home.dart';

import '../models/articles.dart';
import '../parsers/news_parser.dart';
import '../screens/Bookmark.dart';

class BottomNavBar extends StatefulWidget {
  Function onPageChange;
  int position;
  static const String _apiKey = 'a76eab3a9db6401986b50fc441c1ce56';
  static const String _baseurl = 'https://newsapi.org/v2/top-headlines';

  BottomNavBar({required this.onPageChange, required this.position});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  Future? _api;
  Articles? _articles;
  static const List<String> _categoryList = [
    'science',
    'business',
    'sports',
  ];
  // int index;
  String _category = _categoryList[0];
  List<Widget>? _pages;
  @override
  void initState() {
    super.initState();
    _api = callApi();
  }

  @override
  Widget build(BuildContext context) {
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
          // selectedLabelStyle: TextStyle(),
          onTap: (ind) => widget.onPageChange(ind),
          currentIndex: widget.position,
          items: const [
            BottomNavigationBarItem(
              // icon:Wrap( children:const [Icon(Icons.home),
              //  Padding(padding:EdgeInsets.only(top: 3,left: 5),child: Text('home',style: TextStyle(color: Colors.white),)),]),
              // label: '',
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(
                icon: Icon(Icons.notification_add), label: 'Notification'),
            BottomNavigationBarItem(icon: Icon(Icons.save), label: "saved"),
            BottomNavigationBarItem(icon: Icon(Icons.boy), label: "user")
          ],
        ));
  }

  void categoryChangeButtonClick(int index) {
    setState(() {
      _category = _categoryList[index];
      _api = callApi();
    });
  }

  Future callApi() async {
    print('call api again call');
    Dio dio = Dio();
    Response response = await dio.get(getApi());//--------------------- this is wrong
    Map map=response.data;
    _articles = NewsParser.parseArticles(map['articles']);
    addPages();
    return response.data;
  }

  String getApi() {
    return '${BottomNavBar
        ._baseurl}?country=us&category=$_category&apiKey=${BottomNavBar
        ._apiKey}';
  }
  void addPages(){
    _pages = [
      Home(
        key: UniqueKey(),
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
}
