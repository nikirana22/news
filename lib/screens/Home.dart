import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

import '../providers/news.dart';
import '../widgets/bottom_news.dart';
import '../widgets/news_daat.dart';
import '../widgets/tranding.dart';
import 'detail_screen.dart';

//TODO : what is the diff between provider.of() and

class Home extends StatelessWidget {
  static const String login = "/login";
  VoidCallback moreButtonClick;
  String category;
  List<String> categoryList;
  List<News> articles;
  Function categoryChangeButtonClick;

  Home(
      {required this.category,
      required this.categoryList,
      required this.articles,
      required this.categoryChangeButtonClick,
      required this.moreButtonClick,
      Key? key})
      : super(key: key);

//https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=a76eab3a9db6401986b50fc441c1ce56
  //TODO  Try to change the color of the  container on Button click
  @override
  Widget build(BuildContext context) {
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
                tabs: [
                  Tab(
                    text: categoryList[0].toString(),
                  ),
                  Tab(text: categoryList[1].toString()),
                  Tab(text: categoryList[2].toString()),
                ],
                onTap: (index) => categoryChangeButtonClick(index),
                labelColor: const Color.fromRGBO(182, 105, 122, 1),
                indicatorColor: const Color.fromRGBO(182, 105, 122, 1),
                unselectedLabelColor: Colors.black26,
              )),
          body: Column(
            children: [
              Container(
                color: Colors.white,
                padding: const EdgeInsets.only(top: 20),
                height: 210,
                width: double.infinity,
                child: Swiper(
                    controller: SwiperController(),
                    //TODO find out on and off logic
                    loop: false,
                    scale: 0.85,
                    viewportFraction: 0.8,
                    itemCount: articles.length,
                    itemBuilder: (_, index) {
                      if (articles[index].urlToImage != null) {
                        return NewsData(
                          author: articles[index].author.toString(),
                          index: index,
                          image: articles[index].urlToImage!,
                          title: articles[index].title!,
                          imageClick: gotoDetailsPage,
                        );
                      } else {
                        return const Text('No data found');
                      }
                    }),
              ),
              Tranding(
                moreButtonClick: moreButtonClick,
              ),
              BottomNews(
                articles: articles,
              ),
            ],
          )),
    );
  }

  void gotoDetailsPage(int index, BuildContext context) {
    Navigator.pushNamed(context, NewsDetails.routeName,
        arguments: articles[index]);
  }
}
