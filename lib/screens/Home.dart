import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:news/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import '../dao/dao.dart';
import '../database/dao_database.dart';
import '../entity/dao_data.dart';
import '../parsers/news_parser.dart';
import '../providers/news.dart';
import '../widgets/bottom_news.dart';
import '../widgets/news_daat.dart';
import '../widgets/tranding.dart';
import 'detail_screen.dart';

//TODO : what is the diff between provider.of() and

class Home extends StatefulWidget {
  static const String login = "/login";
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  var _isLoading = true;
  List<News>? _articles = [];
  // Future<bool> hasNetwork() async {
  //   try {
  //     final result = await InternetAddress.lookup('example.com');
  //     return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  //   } on SocketException catch (_) {
  //     return false;
  //   }
  // }
  // late DaoDatabase _data;
  // Dao? _dao;

  static const List<String> _categoryList = [
    'science',
    'business',
    'sports',
  ];

  String _category = _categoryList[0];

//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a76eab3a9db6401986b50fc441c1ce56

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    initArticles();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      //clear db first
      clearAndUpdateDB();
    }
  }

  @override
  Widget build(BuildContext context) {
    //todo data is increasing in database on every paused
    // todo database design in flutter

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: Appbar(categoryChangeButtonClick: categoryChangeButtonClick,categoryList: _categoryList,),
          body:
          // _isLoading
          //     ?
              // ?databaseDataInWidget():
              //  const Center(child: CircularProgressIndicator())
              // :
          StreamBuilder(
                  stream: Connectivity().onConnectivityChanged,
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (snapshot.data == ConnectivityResult.wifi ||
                        snapshot.data == ConnectivityResult.mobile) {
                      print('if statement yes ');
                      return buildHomeScreen();
                    }
                    else if(snapshot.data==ConnectivityResult.none){
                      checkData();
                      print('else statement my ');

                      return buildHomeScreen();
                      // return Text('else statement',style: TextStyle(color: Colors.white),);
                    }
                    else if(snapshot.data==null){
                      checkData();
                      return buildHomeScreen();
                    }
                    //Check if there is no data for the category in db as well then show no internet msg
                    else{
                      return const Text('else statement something is going wrong');
                    }
                  },
                )),
    );
  }

  Future<void> clearAndUpdateDB() async {
    await deleteDb();
    databaseDataAdded();
  }

  void databaseDataAdded() async {
    Dao dao = await getDao();
    print('----------------------------------------------------------');
    _articles?.forEach((e) {
      dao.addData(DataDao(
          author: e.author,
          title: e.title,
          description: e.description,
          url: e.url,
          urlToImage: e.urlToImage,
          publishedAt: e.publishedAt,
          content: e.content));
      print('data is adding }');
    });
  }

  Widget buildHomeScreen() {
    return _articles!.isNotEmpty? Column(
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 20),
          height: 210,
          width: double.infinity,
          child: Swiper(
              controller: SwiperController(),
              //TODO find out on and off logic
              loop: false,
              scale: 0.85,
              viewportFraction: 0.8,
              itemCount: _articles?.length,
              itemBuilder: (_, index) {
                if (_articles![index].urlToImage != null) {
                  return NewsData(
                    author: _articles![index].author.toString(),
                    index: index,
                    image: _articles![index].urlToImage!,
                    title: _articles![index].title!,
                    imageClick: gotoDetailsPage,
                  );
                } else {
                  return const Text('No..............');
                }
              }),
        ),
        Tranding(

          moreButtonClick: moreButtonClick,
        ),
        BottomNews(
          articles: _articles!,
        ),
      ],
    ):CircularProgressIndicator();
  }

  void getDataa() async {
    Dao dao = await getDao();
    List<DataDao> list = await dao.getData();
    print(list);
    print('database data is getting ${list.length}');
  }
  void checkData() async {
    Dao dao = await getDao();
    List<DataDao> list = await dao.getData();
    print(list);
    if(list.isEmpty){
      print('No data found');
    }
    else{
    setState(() {
      _articles = NewsParser.change(list);
    });
    // databaseDataAdded();
    }
  }
  Future<void> deleteDb() async {
    Dao dao = await getDao();
    dao.clearDb();
  }

  Future<Dao> getDao() async {
    DaoDatabase database =
        await $FloorDaoDatabase.databaseBuilder('apidata').build();
    Dao dao = database.datadao;
    return dao;
  }

  void moreButtonClick() {
    print('clicked');
    getDataa();
    // checkData();
  }

  void categoryChangeButtonClick(int index) {
    setState(() {
      _category = _categoryList[index];
      initArticles();
    });
  }

  Future<void> initArticles() async {
    // setState(() {
    //   _isLoading = true;
    // });
    final provider = Provider.of<Articles>(context, listen: false);
    await provider.fetchArticlesForCategory(_category);
    setState(() {
      _isLoading = false;
      _articles = provider.newsList;
    });
  }

  void gotoDetailsPage(int index, BuildContext context) {
    Navigator.pushNamed(context, NewsDetails.routeName,
        arguments: _articles![index]);
  }
}
