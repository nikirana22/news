import 'package:flutter/material.dart';

//Todo try to find out switch button on and off logic
//Todo try to make to text like UI (next image text is showing try to hide it)
// import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './HeaderList.dart';
import './body.dart';
import 'package:news/detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<ChangeTheme>(
    create: (ref) => ChangeTheme(),
    child: MyApp(),
  ));
}

//TODO 5/14/2022: Refactor layout to make FutureBuilder as root Layout
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChangeTheme>(builder: (context, value, child) {
      return MaterialApp(
        // themeMode: ThemeMode.dark,
        routes: {Details.routeName: (context) => Details()},
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            textTheme: const TextTheme(
                headline1: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'first',
                    fontSize: 20,
                    color: Colors.white),
                headline2: TextStyle(
                  fontSize: 27,
                  color: Colors.blueGrey,
                ),
                headline3: TextStyle(
                    fontFamily: 'second', fontSize: 20, color: Colors.cyan))),
        themeMode: value._light ? ThemeMode.light : ThemeMode.dark,
        darkTheme: ThemeData(
            primaryColor: Colors.purple, backgroundColor: Colors.black),
        // darkTheme: ThemeData.localize(value.themeData, TextTheme()),
        // darkTheme: ThemeData(primaryColor: Colors.blueAccent),
        home: _MyHomePageState(value),
// )
      );
    });
  }
}

class _MyHomePageState extends StatefulWidget {
  ChangeTheme object;

  _MyHomePageState(this.object);

  void onClick(String data) {
    print(data);
  }

  @override
  State<StatefulWidget> createState() {
    return Second();
  }
}

class Second extends State<_MyHomePageState> {
  Map? _map;
  static const List<String> _categoryList = ['science', 'business', 'sports'];

  // String _category = _categoryList[0];
  static const String _API_KEY = 'a76eab3a9db6401986b50fc441c1ce56';
  String baseurl = 'https://newsapi.org/v2/top-headlines';

  static Orientation? checkScreenMode;

  // Object object;
  double? clipItemContainerHeight;
  double? imageHeight;
  double? imageContainerHeight;
  int bottomNavigationSelectedItemIndex = 0;

  // Second(this.object);

  String getApi(String category) {
    return '${baseurl}?country=us&category=${category}&apiKey=$_API_KEY';
  }

  @override
  Widget build(BuildContext context) {
    print(getApi(_categoryList[0]));
    print('Width is  ${MediaQuery.of(context).size.width}');
    print('Height is  ${MediaQuery.of(context).size.height}');

    bool switchvalue = true;

    return OrientationBuilder(builder: (context, orientation) {
      checkScreenMode = orientation;

      if (orientation == Orientation.portrait) {
        clipItemContainerHeight = MediaQuery.of(context).size.height * 0.07;
        imageContainerHeight = MediaQuery.of(context).size.height * 0.72;
        imageHeight = MediaQuery.of(context).size.height * 0.55;
      } else {
        imageContainerHeight = 177;
        imageHeight = MediaQuery.of(context).size.height * 0.401;
        clipItemContainerHeight = MediaQuery.of(context).size.height * 0.12;
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Sports',
              style: TextStyle(
                  fontFamily: 'first',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: clipItemContainerHeight,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: _categoryList.length,
                    itemBuilder: (_, item) {
                      return Header(
                          data: _categoryList[item], onClick: onClick);
                    },
                    //TODO  Try to change the color of the  container on Button click
                    scrollDirection: Axis.horizontal,
                  )),
              FutureBuilder(
                future: callApi(_categoryList[0]),
                builder: (contx, data) {
                  if (data.hasData) {
                    print(data);

                    return Container(
                      padding: EdgeInsets.only(top: 20),
                      // color: Colors.amber,
                      width: double.infinity,
                      height: imageContainerHeight,
                      child: Swiper(
                          //TODO find out on and off logic
                          loop: false,
                          // onTap: (index) {
                          //   Navigator.of(context).pushNamed('details',
                          //       arguments: _map!['articles'][index]);
                          // },
                          scale: 0.8,
                          viewportFraction: 0.7,
                          itemCount: _map!['articles'].length,
                          itemBuilder: (constext, it) {
                            return Center(
                                child: _map!['articles'][it]['urlToImage'] !=
                                        null
                                    ? Body(
                                        index: it,
                                        image: _map!['articles'][it]
                                            ['urlToImage'],
                                        title: _map!['articles'][it]['title'],
                                        imageHeight: imageHeight!,
                                        imageClick: imageClick,
                                      )
                                    : Container(
                                        height: imageHeight,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.cyan),
                                        child: const Center(
                                          child: Text('No Data Found'),
                                        ),
                                      ));
                          }),
                    );
                  } else {
                    return Container(
                      color: Colors.red,
                    );
                  }
                },
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.black26,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.black26,
          onTap: (index) {
            setState(() {
              bottomNavigationSelectedItemIndex = index;
            });
          },
          currentIndex: bottomNavigationSelectedItemIndex,
          items: const [
            // ...aalbottom().map((e) => e).toList()
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(
                  Icons.home,
                ),
                label: 'bookmark'),
            BottomNavigationBarItem(
                backgroundColor: Colors.green,
                icon: Icon(
                  Icons.book,
                ),
                label: 'bookmark'),
            BottomNavigationBarItem(
                backgroundColor: Colors.cyanAccent,
                icon: Icon(
                  Icons.person,
                ),
                label: 'bookmark'),
            BottomNavigationBarItem(
                backgroundColor: Colors.amber,
                icon: Icon(
                  Icons.settings,
                ),
                label: 'bookmark')
          ],
        ),
      );
    });

    //  Image Container Height =>  height: MediaQuery.of(context).size.height*0.72,
  }

  void onClick(String data) {
    callApi(data);
  }

  //
  void imageClick(int index) {
    Navigator.pushNamed(context, Details.routeName,
        arguments: _map!['articles'][index]);
  }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   callApi(_category);
  // }

  Future callApi(String data) async {
    Dio dio = Dio();
    Response response = await dio.get(getApi(data));
    return _map = response.data;
  }

  List<BottomNavigationBarItem> aalbottom() {
    List<BottomNavigationBarItem> b = const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: 'bookmark'),
      BottomNavigationBarItem(icon: Icon(Icons.book), label: 'bookmark'),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: 'bookmark'),
      BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'bookmark')
    ];
    return b;
  }
}

class ChangeTheme extends ChangeNotifier {
  bool _light = true;
  ThemeData themeData = ThemeData.light();

  void redTheme() {
    if (_light == true) {
      themeData = ThemeData.light();
      print('if');
    } else {
      print('else ');
      themeData = ThemeData.dark();
    }
    _light = !_light;
    notifyListeners();
  }

  void getTheme() {
    if (_light) {
      themeData = ThemeData.dark();
    } else {
      themeData = ThemeData.light();
    }
    _light = !_light;
    notifyListeners();
  }
}
//TODO 5/6/2022:What is Future?
