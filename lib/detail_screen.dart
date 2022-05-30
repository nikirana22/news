import 'package:flutter/material.dart';
import '../models/news.dart';
import '../widgets/SecondCont.dart';

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
                  padding: EdgeInsets.only(right: 30), child: Icon(Icons.save))
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
            bottom: AppBarCustom(),
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
                      DetailsNewsTitle(data.title.toString(),
                          Theme.of(context).textTheme.headline1),
                      DetailsNewsTitle(data.description.toString(),
                          Theme.of(context).textTheme.headline2),
                      DetailsNewsTitle(data.content.toString(),
                          Theme.of(context).textTheme.headline3),
                    ],
                  )),
            ]),
          )
        ]));
  }
}

class AppBarCustom extends StatelessWidget with PreferredSizeWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 50,
      padding:const EdgeInsets.symmetric(horizontal: 35),
      // margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: const [
          Icon(
            Icons.facebook,
            color: Colors.white60,
          ),
          Icon(
            Icons.whatsapp,
            color: Colors.white60,
          ),
          Icon(
            Icons.email,
            color: Colors.white60,
          ),
          Icon(
            Icons.share,
            color: Colors.white60,
          ),
          Icon(
            Icons.favorite,
            color: Colors.white60,
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(80);
}
