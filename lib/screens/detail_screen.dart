import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/recently_watch_news.dart';
import '../widgets/news_details_appbar.dart';
import '../providers/news.dart';

class NewsDetails extends StatelessWidget {
  static const String routeName = '/details';
  bool? isOnline;

  NewsDetails({Key? key, required this.isOnline}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    News news = ModalRoute.of(context)?.settings.arguments as News;
   // News data=map['data'];
  //  int index=map['index'];
    // RecentlyWatchNews recentlyWatch=Provider.of<RecentlyWatchNews>(context,listen: false);
    // recentlyWatch.addRecentlyWatchNews(news);

    return Scaffold(
        backgroundColor: Colors.black12,
        body: CustomScrollView(slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            // TODO : INTL package
            forceElevated: true,
            elevation: 5,
            pinned: true,
            backgroundColor: Colors.black,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Consumer<Articles>(
                    builder: (_,articles,child){
                      return IconButton(
                        icon: news.isFavorite
                            ?const Icon(Icons.bookmark,color: Colors.red,):const Icon(Icons.bookmark,),
                        onPressed: () {
                          if(!news.isFavorite) {

                            // articles.newsList[0].isFavorite=true;
                            articles.addFavoriteNews(news);
                            // articles.favoriteNews(index);
                          }
                          else{
                            news.isFavorite=false;
                            articles.removeFavoriteNews(news.id);
                          }
                        },
                      );
                    },
                  )
              )
            ],
            expandedHeight: 290,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  isOnline == true
                      ? Image.network(
                          news.urlToImage.toString(),
                          fit: BoxFit.fitHeight,
                          height: 310,
                        )
                      : Image.file(
                          File(news.urlToImage.toString()),
                          height: 310,
                          fit: BoxFit.fitHeight,
                        ),
                  Positioned(
                      top: 140,
                      left: 30,
                      right: 20,
                      bottom: 5,
                      child: Text(
                        news.title.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 22, color: Colors.white),
                      )

                    // news.author != null
                      //     ?                           : const Text('author',
                      //         style:
                      //             TextStyle(fontSize: 20, color: Colors.white))
                  )
                ],
              ),
            ),
            bottom:const NewsDetailsAppBar(),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                  width: 100,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30))),
                  child: Column(
                    children: [
                      newsContent(news.title.toString().toString(),
                          Theme.of(context).textTheme.headline1),
                      newsContent(news.description.toString().toString(),
                          Theme.of(context).textTheme.headline2),
                      newsContent(news.content.toString().toString(),
                          Theme.of(context).textTheme.headline3),
                    ],
                  )),
            ]),
          )
        ]));
  }

  Widget newsContent(String text, TextStyle? style) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          text,
          style: style,
        ));
  }
}
