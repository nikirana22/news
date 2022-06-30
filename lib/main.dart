import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../screens/Home.dart';
import '../helpers/page_change_helper.dart';
import '../providers/database_provider.dart';
import '../providers/news.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Articles(),
        ),
        ChangeNotifierProvider.value(value: PageChangeHelper()),
        ChangeNotifierProvider.value(value: DatabaseProvider()),
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

class _MyHomePage extends StatelessWidget {

  List<Widget> pageList = [
    Home(),
    Container(
      color: Colors.white60,
    ),
    Container(
      color: Colors.purple,
    ),
    Container(
      color: Colors.yellow,
    )];

  @override
  Widget build(BuildContext context) {
    PageChangeHelper changePages = Provider.of<PageChangeHelper>(context);
    return Scaffold(
        backgroundColor: Colors.black,
        body:
            // changePages.pages.pageList[changePages.pages.selectedPos],
        pageList[changePages.selectedPos],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          onTap: (index) {
            changePages.pagechanged(index);
          },
          currentIndex: changePages.selectedPos,
          items: const [
            BottomNavigationBarItem(
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
}