import 'package:flutter/material.dart';
import 'package:news/Login.dart';
import 'package:news/my-provider.dart';
import 'package:news/widgets/bottom_nav_bar.dart';
import './CustomAppBar.dart';

//Todo try to find out switch button on and off logic
//Todo try to make to text like UI (next image text is showing try to hide it)

// Todo ------------>>>>>>>>BOOKMARK  <<<<<<<<<<<<---------
import './screens/Bookmark.dart';
import './detail_screen.dart';
import './screens/Home.dart';
import './SecondPage/categorypage.dart';

void main() {
  runApp(
    MyApp(),
  );
}
//TODO 5/14/2022: Refactor layout to make FutureBuilder as root Layout

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        // Home.login:(context)=>Home(),
        NewsDetails.routeName: (context) => NewsDetails(),
        CategoryPage.data: (context) => CategoryPage(),

      },
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
    );
  }
}
class _MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

//TODO 20-05-2022: Make this class private
//TODO 20-05-2022: Why is favoriteNewsData static?
//TODO 20-05-2022: Need to fix like icon updating after a little drag on ListView.
// P.S: It's an IconButton & it's state is getting updated when ListView updates itself.
//TODO 20-05-2022: Need to fix like icon updating after a little drag on ListView.
//TODO 20-05-2022: Figure out ways to make custom AppBar.

class _MyHomePageState extends State<_MyHomePage> {
  // Map _favoriteNewsData = {}; // here is some issue
  int _selectedPos = 0;

  @override
  Widget build(BuildContext context) {
    return  BottomNavBar(onPageChange: onPageChange,position:_selectedPos);
    // return Home();
  }
  void loginButton(String email,String password){
    print(email);
    if(email!=''&&password!='') {
      Navigator.pushReplacementNamed(context, Home.login);
      Navigator.pushNamed(context, Home.login,arguments: {'email':email,'pass':password});
    }
  }
  void onPageChange(int index){
    setState(() {
      _selectedPos=index;
      print('this is my $index');
    });
  }
}
//TODO 5/6/2022:What is Future?
