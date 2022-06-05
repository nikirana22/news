import 'package:flutter/material.dart';
import 'package:news/changeconnectivity/change_notifier.dart';
import 'package:news/widgets/api_data.dart';
import 'package:provider/provider.dart';

import './SecondPage/categorypage.dart';

// Todo ------------>>>>>>>>BOOKMARK  <<<<<<<<<<<<---------
import './detail_screen.dart';
import './screens/Home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //TODO: can we make this class Singleton
  runApp(ChangeNotifierProvider<ChangeConnectivity>(
          create: (context) {
            return ChangeConnectivity();
          },
          child: MyApp())
      // MyApp(dao: dao),
      );
}
//TODO 5/14/2022: Refactor layout to make FutureBuilder as root Layout

class MyApp extends StatelessWidget {
  // Dao dao;
  // MyApp({required this.dao,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        NewsDetails.routeName: (context) => const NewsDetails(),
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
      // home: _MyHomePage(dao: dao,),
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  // Dao dao;
  // _MyHomePage({required this.dao});
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
  int _selectedPos = 0;

//----------------------------------------------------
//--  //TODO : which method calls in last (Destroy)  --
//-----------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return ApiData(onPageChange: onPageChange, position: _selectedPos);

    // ApiData(onPageChange: onPageChange,position:_selectedPos,);
  }

  void loginButton(String email, String password) {
    print(email);
    if (email != '' && password != '') {
      Navigator.pushReplacementNamed(context, Home.login);
      Navigator.pushNamed(context, Home.login,
          arguments: {'email': email, 'pass': password});
    }
  }

  void onPageChange(int index) {
    setState(() {
      _selectedPos = index;
      print('this is my $index');
    });
  }
}
//TODO 5/6/2022:What is Future?
