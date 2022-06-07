import 'package:flutter/material.dart';
import 'package:news/widgets/news_details_appbar.dart';

import '../providers/news.dart';
import '../../widgets/details_news_title.dart';

class NewsDetails extends StatelessWidget {
  static const String routeName = '/details';

  const NewsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    News data = ModalRoute.of(context)?.settings.arguments as News;
    //TODO 5/14/2022: Handle Orientation change
    //TODO 5/14/2022: Expanded vs Flexible
    //TODO 5/14/2022: Creating separate Widgets vs builder methods
    //TODO 5/14/2022: LayoutBuilder
    //TODO 5/14/2022: Animations in Flutter
    //TODO 5/14/2022: Top 10 libraries in Flutter
    //TODO 5/14/2022: Getting User Input
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
            actions: const [
              Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Icon(Icons.bookmark))
            ],
            // backgroundColor: Colors.black,
            expandedHeight: 290,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Image.network(
                    data.urlToImage.toString(),
                    fit: BoxFit.fitHeight,
                    height: 310,
                  ),
                  Positioned(
                      top: 140,
                      left: 30,
                      right: 20,
                      bottom: 5,
                      child: data.author != null
                          ? Text(
                              data.title.toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 22, color: Colors.white),
                            )
                          : const Text('author',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white)))
                ],
              ),
            ),
            bottom: NewsDetailsAppBar(),
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
                      DetailsNewsTitle(
                        titleData: data.title.toString(),
                        textStyle: Theme.of(context).textTheme.headline1,
                      ),
                      DetailsNewsTitle(
                        titleData: data.description.toString(),
                        textStyle: Theme.of(context).textTheme.headline2,
                      ),
                      DetailsNewsTitle(
                        titleData: data.content.toString(),
                        textStyle: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  )),
            ]),
          )
        ]));
  }
}
