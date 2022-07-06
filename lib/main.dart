import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/favorite.dart';
import '../providers/recently_watch_news.dart';
import '../screens/recently_watch.dart';
import '../screens/Home.dart';
import '../providers/database_provider.dart';
import '../providers/news.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Articles(),),
        ChangeNotifierProvider.value(value: DatabaseProvider()),
        ChangeNotifierProvider.value(value: RecentlyWatchNews())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: const TextTheme(
            headline1: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Regular',
                fontSize: 20,
                color: Colors.black54),
            headline2: TextStyle(
              fontSize: 27,
              color: Colors.blueGrey,
            ),
            headline3: TextStyle(
                fontFamily: 'Regular', fontSize: 20, color: Colors.grey),
          ),
        ),
        home: _MyHomePage(),
      )));
}

class _MyHomePage extends StatefulWidget {

  @override
  State<_MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<_MyHomePage> {
  int _selectedPage=0;

  List<Widget> pageList = [
    Home(),
    Favorite(),
    RecentlyWatch(),
    Container(
      color: Colors.yellow,
    )];

  @override
  Widget build(BuildContext context) {
    // PageChangeHelper changePages = Provider.of<PageChangeHelper>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        // body:Favorite(),
            // changePages.pages.pageList[changePages.pages.selectedPos],
        // body:pageList[changePages.selectedPos],
        body:IndexedStack(
          index: _selectedPage,
          children: pageList,
        ),
        // body:RecentlyWatch(),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
            backgroundColor: Colors.black,
          unselectedItemColor: Colors.white60,
          onTap: (index) {
            setState((){
              _selectedPage=index;
            });
          },
          currentIndex: _selectedPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black),
            BottomNavigationBarItem(backgroundColor: Colors.black,
                icon: Icon(Icons.favorite), label: 'favorite'),
            BottomNavigationBarItem(backgroundColor: Colors.black,icon: Icon(Icons.remove_red_eye), label: "recentlywatch"),
            BottomNavigationBarItem(backgroundColor: Colors.black,icon: Icon(Icons.boy), label: "user")
          ],
        ));
  }
}