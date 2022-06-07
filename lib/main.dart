import 'package:flutter/material.dart';
import 'package:news/providers/news.dart';
import 'package:news/screens/Home.dart';
import 'package:provider/provider.dart';
import 'screens/detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
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
        headline3:
            TextStyle(fontFamily: 'Regular', fontSize: 20, color: Colors.grey),
      ),
    ),
    home: _MyHomePage(),
  ));
}
class _MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<_MyHomePage> {
  int _selectedPos = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addPages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.black,
        body: ChangeNotifierProvider(
          create: (_) => Articles(),
          child: _pages[_selectedPos],
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          onTap: (index) {
            setState(() {
              print('your index is $index');
              _selectedPos = index;
            });
          },
          currentIndex: _selectedPos,
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

  void addPages() {
    _pages = [
      Home(),
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

// void loginButton(String email, String password) {
//   print(email);
//   if (email.isNotEmpty && password.isNotEmpty) {
//     Navigator.pushReplacementNamed(context, Home.login);
//     Navigator.pushNamed(context, Home.login,
//         arguments: {'email': email, 'pass': password});
//   }
// }

}
//TODO 5/6/2022:What is Future?
