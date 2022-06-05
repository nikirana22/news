import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/providers/news.dart';
import 'package:provider/provider.dart';

import '../dao/dao.dart';
import '../database/dao_database.dart';
import '../entity/dao_data.dart';
import '../parsers/news_parser.dart';
import '../screens/Home.dart';
import '../utils/change_notifier.dart';

//TODO 01/06/2022: Check API if there is an endpoint which can give all
// category data at once so we can filter it later on in app
class ApiData extends StatefulWidget {
  @override
  State<ApiData> createState() => _ApiDataState();
}

class _ApiDataState extends State<ApiData> with WidgetsBindingObserver {
  int position = 0;
  List<News>? _articles;
  late DaoDatabase data;
  Dao? dao;

  static const List<String> _categoryList = [
    'science',
    'business',
    'sports',
  ];
  String _category = _categoryList[0];
  List<Widget>? _pages = [];

  void getDatabaseObj() async {
    data = await $FloorDaoDatabase.databaseBuilder('apidata').build();
    dao = data.datadao;
  }

  @override
  void initState() {
    super.initState();
    getDatabaseObj();
    WidgetsBinding.instance?.addObserver(this);
  }

  Future<void> initArticles() async {
    final provider = Provider.of<Articles>(context);
    await provider.fetchArticlesForCategory(_category);
    setState(() {
      _articles = provider.newsList;
    });
  }

  void getDataa() async {
    List<DataDao> list = await dao!.getData();
    print('database data is getting ${list.length}');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('----------------------------------------------------------');
      _articles?.forEach((e) {
        dao?.addData(DataDao(
            author: e.author,
            title: e.title,
            description: e.description,
            url: e.url,
            urlToImage: e.urlToImage,
            publishedAt: e.publishedAt,
            content: e.content));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    initArticles();
    return ChangeNotifierProvider(
      create: (_) => Articles(),
      child: Consumer<ChangeConnectivity>(builder: (context, builder, child) {
        Connectivity().onConnectivityChanged.listen((event) {
          builder.connectivityChange(event);
          print(builder.connectivityResult);
        });
        // if(builder.connectivityResult==ConnectivityResult.wifi){
        // getDataa();
        return Scaffold(
            /*if (snapshot.hasData) {
          return _pages![position];
        } else {
        return const Center(child: CircularProgressIndicator());
        }*/
            backgroundColor: Colors.black,
            body: _articles?.isNotEmpty ?? false
                ? _pages![position]
                : const Center(child: CircularProgressIndicator()),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white60,
              // onTap: (ind) => widget.onPageChange(ind),
              currentIndex: position,
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
            ));
      }),
    );
  }

  void categoryChangeButtonClick(int index) {
    setState(() {
      _category = _categoryList[index];
      // _api = callApi();
    });
  }

  Future<dynamic> callApi() async {}

  void addPages() {
    _pages = [
      Home(
        moreButtonClick: moreButtonClick,
        category: _category,
        categoryList: _categoryList,
        articles: _articles!,
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
      ),
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
  // Map getMap(Map map) {
  //   DataDao dataDao = DataDao(
  //       author: map['author'],
  //       title: map['title'],
  //       description: map['description'],
  //       url: map['url'],
  //       urlToImage: map['urlToImage'],
  //       publishedAt: map['publishedAt'],
  //       content: map['content']);
  //   widget.dao?.addData(dataDao);
  //   return map;
  // }

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
