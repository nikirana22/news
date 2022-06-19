import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../providers/database_provider.dart';
import 'package:provider/provider.dart';
import '../providers/news.dart';
import '../widgets/bottom_news.dart';
import '../widgets/top_news.dart';
import '../widgets/tranding.dart';

//TODO : what is the diff between provider.of() an
class Home extends StatefulWidget {
  static const String login = "/login";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  List<News> _newList = [];
  late bool _isOnline;

  //https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a76eab3a9db6401986b50fc441c1ce56

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    fetchData();
  }

  void fetchData() async {
    // var connectivityCheck = await ConnectivityProvider.getConnectivity();
    var connectivityCheck=await Connectivity().checkConnectivity(); // todo we don't need ConnectivityProvider if we do this
    if (connectivityCheck == ConnectivityResult.wifi ||
        connectivityCheck == ConnectivityResult.mobile) {
      Articles articles = Provider.of<Articles>(context, listen: false);
      await articles.fetchArticlesForCategory();
      setState(() {
        _newList = articles.newsList;
        _isOnline=true;
      });
    } else if(connectivityCheck==ConnectivityResult.none){/*if db has items*/
      DatabaseProvider databaseProvider=Provider.of<DatabaseProvider>(context,listen: false);
      await databaseProvider.getDataFromDatabase();
      setState(() {
        _newList=databaseProvider.articlesDatabase;
        _isOnline=false;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      databaseAdded();
    }
  }
  @override
  Widget build(BuildContext context) {

    //todo image server error 503 (server is temporarily unable to handle the request)
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: const Padding(
                    padding: EdgeInsets.only(top: 4, left: 10),
                    child: Icon(
                      Icons.menu,
                      color: Colors.black,
                    )),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.supervised_user_circle,
                          color: Colors.grey,
                          size: 35,
                        )),
                  ),
                ],
                bottom: TabBar(
                  labelStyle: const TextStyle(fontSize: 25),
                  unselectedLabelStyle: const TextStyle(fontSize: 15),
                  tabs: [
                    Tab(text: Articles.categoryList[0].toString()),
                    Tab(text: Articles.categoryList[1].toString()),
                    Tab(text: Articles.categoryList[2].toString()),
                  ],
                  onTap: (index) {
                    onCategoryChange(index);
                  },
                  labelColor: const Color.fromRGBO(182, 105, 122, 1),
                  indicatorColor: const Color.fromRGBO(182, 105, 122, 1),
                  unselectedLabelColor: Colors.black26,
                )),
            body: buildHomeScreen()));
  }

  Widget buildHomeScreen( ) {
    return _newList.isNotEmpty
        ? Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 10),
                height: 200,
                width: double.infinity,
                child: Swiper(
                    controller: SwiperController(),
                    //TODO find out on and off logic
                    loop: false,
                    scale: 0.85,
                    viewportFraction: 0.8,
                    itemCount: _newList.length,
                    itemBuilder: (_, index) {
                      if (_newList[index].urlToImage != null) {
                        return TopNews(
                          newsData: _newList[index],
                          isOnline: _isOnline,
                          // connectivityResult: connection,
                          index: index,
                        );
                      } else {
                        return Container(
                            height: 150,
                            margin: const EdgeInsets.only(bottom: 5),
                            color: Colors.purpleAccent,
                            child: const Text('No..............'));
                      }
                    }),
              ),
              Tranding(),
              BottomNews(
                isOnline: _isOnline,
                articles: _newList,
              ),
            ],
          )
        : const CircularProgressIndicator();
  }
  void fatchApiData(Articles articles) async {
    if (articles.newsList.isEmpty) {
      await articles.fetchArticlesForCategory();
      setState(() {
        _newList = articles.newsList;
      });
    }
  }

  void onCategoryChange(int index)async{
    Articles articles=Provider.of<Articles>(context,listen: false);
    articles.categoryChangeButtonClick(index);

    await articles.fetchArticlesForCategory();
    setState(() {
      _newList=articles.newsList;
    });
  }
  void databaseAdded() {
    DatabaseProvider databaseProvider =
        Provider.of<DatabaseProvider>(context, listen: false);
    databaseProvider.databaseDataAdded(_newList);
  }
}
