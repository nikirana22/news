import 'package:flutter/material.dart';
import './utils/change_notifier.dart';
import 'package:news/widgets/api_data.dart';
import 'package:provider/provider.dart';

import 'screens/detail_screen.dart';
import './screens/Home.dart';
import 'dao/dao.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ChangeNotifierProvider<ChangeConnectivity>(
          create: (context) {
            return ChangeConnectivity();
          },
          child: MyApp())
      );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        NewsDetails.routeName: (context) => const NewsDetails(),
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

class _MyHomePageState extends State<_MyHomePage> {
  int _selectedPos = 0;

  @override
  Widget build(BuildContext context) {
    return ApiData();

  }

  void loginButton(String email, String password) {
    print(email);
    if (email.isNotEmpty && password.isNotEmpty) {
      Navigator.pushReplacementNamed(context, Home.login);
      Navigator.pushNamed(context, Home.login,
          arguments: {'email': email, 'pass': password});
    }
  }

  void onPageChange(int index) {
    setState(() {
      _selectedPos = index;
    });
  }
}
//TODO 5/6/2022:What is Future?
