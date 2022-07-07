import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import '../providers/news.dart';
import '../widgets/bottom_news.dart';
import '../widgets/top_news.dart';
import '../widgets/tranding.dart';
import '../providers/database_provider.dart';

class Home extends StatefulWidget {
  // static const String login = "/login";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  List<News> _newList = [];
  late bool _isOnline;
  //todo Can we change this class from StatefulWidget to StatelessWidget
//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a76eab3a9db6401986b50fc441c1ce56

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    fetchData();
  }

  // we can make a common provider for fetching the data from Api as well as Database
  // that provider will check the connectivity if user doesn't have internet then that provider will give us Database data
  //otherwise it will give us Api Data
  void fetchData() async {
    // todo i want to send this method in provider class. is it correct to check Connectivity() on UI
    var connectivityCheck = await Connectivity().checkConnectivity();
    if (connectivityCheck == ConnectivityResult.wifi ||
        connectivityCheck == ConnectivityResult.mobile) {
      Articles articles = Provider.of<Articles>(context, listen: false);
      await articles.fetchArticlesForCategory();
      setState(() {
        _newList = articles.newsList;
        _isOnline = true;
      });
    } else if (connectivityCheck == ConnectivityResult.none) {
      /*if db has items*/
      DatabaseProvider databaseProvider =
          Provider.of<DatabaseProvider>(context, listen: false);
      await databaseProvider.getDataFromDatabase();
      setState(() {
        _newList = databaseProvider.articlesDatabase;
        _isOnline = false;
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      Provider.of<DatabaseProvider>(context, listen: false)
          .databaseDataAdded(_newList);
    }
  }
  // void databaseAdded() {
    // DatabaseProvider databaseProvider =

    // databaseProvider.databaseDataAdded(_newList);
  // }


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            backgroundColor: Colors.black,
            appBar: homePageAppBar(),
            body:
                SingleChildScrollView(child: buildHomeScreen())));
  }

  Widget buildHomeScreen() {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;

    return _newList.isNotEmpty
        ? Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 10),
                height: height * 0.28,
                width: double.infinity,
                child: Swiper(
                    controller: SwiperController(),
                    loop: false,
                    scale: 0.85,
                    viewportFraction: 0.8,
                    itemCount: _newList.length,
                    itemBuilder: (_, index) {
                      // if (_newList[index].urlToImage != null) {
                        return TopNews(
                          newsData: _newList[index],
                          isOnline: _isOnline,
                         // index: index,
                        );
                      // } else {
                      //   return Container(
                      //       height: height * 0.26,
                      //       width: width * 1,
                      //       margin: const EdgeInsets.only(bottom: 5),
                      //       color: Colors.purpleAccent,
                      //       child: const Text('No..............'));
                      // }
                    }),
              ),
              Tranding(),
              //todo TimerZome (4 hour before) is pending
              BottomNews(
                isOnline: _isOnline,
                articles: _newList,
              ),
            ],
          )
        : SizedBox(
      height: height*0.8,
          width: width,
          child: const Center(
              child: CircularProgressIndicator(
              color: Colors.white,
            )),
        );
  }

  void onCategoryChange(int index) async {
    Articles articles = Provider.of<Articles>(context, listen: false);
    await articles.categoryChangeButtonClick(index);
    setState(() {
      _newList = articles.newsList;
    });
  }

  PreferredSizeWidget homePageAppBar() {
    return AppBar(
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
            //todo  use Category in this class
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
        ));
  }
}
