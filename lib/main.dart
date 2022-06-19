import 'package:flutter/material.dart';
import 'package:news/helpers/page_change_helper.dart';
import 'package:news/providers/connectivity_provider.dart';
import 'package:news/providers/database_provider.dart';
import 'package:news/providers/news.dart';
import 'package:provider/provider.dart';
import 'screens/detail_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //TODO diff b/w ChangeNotifierProvider.value & ChangeNotifierProvider
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Articles(),
        ),
        ChangeNotifierProvider.value(value: PageChangeHelper()),
        ChangeNotifierProvider.value(value: DatabaseProvider()),
      ],
      child: MaterialApp(
        routes: {
          // NewsDetails.routeName: (context) =>  NewsDetails(isOnline: i,),
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
      )));
}

class _MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<_MyHomePage> {


  @override
  Widget build(BuildContext context) {
    PageChangeHelper changePages = Provider.of<PageChangeHelper>(context);

    return Scaffold(
        backgroundColor: Colors.black,
        body:
            changePages.pages.pageList[changePages.pages.selectedPos],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          onTap: (index) {
            print('your index is $index');
            // changePages.pages.selectedPos = index;
            changePages.pagechanged(index);
          },
          currentIndex: changePages.pages.selectedPos,
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
