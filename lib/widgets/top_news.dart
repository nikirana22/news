import 'dart:io';
import 'package:flutter/material.dart';
import '../providers/news.dart';
import '../screens/detail_screen.dart';

class TopNews extends StatelessWidget {
  int index;

  News newsData;
  bool isOnline;

  TopNews({
    Key? key,
    required this.isOnline,
    required this.newsData,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => gotoDetailsPage(index, context),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: isOnline == true
                      ? FadeInImage(
                          height: 190,
                          fit: BoxFit.fill,
                          placeholder: const AssetImage('placeholder.png'),
                          image: NetworkImage(newsData.urlToImage.toString()),
                        )

                      // Image.network(
                      //         newsData.urlToImage.toString(),
                      //         height: 190,
                      //         fit: BoxFit.fill,
                      //       )
                      : FadeInImage(
                    height: 190,
                    fit: BoxFit.fill,

                      placeholder:const AssetImage('placeholder.png') ,
                              image: FileImage(
                                  File(newsData.urlToImage.toString())),
                              )

                  ),
              Positioned(
                  top: 40,
                  left: 170,
                  child: Text(
                    newsData.author.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  )),
              const Positioned(
                  top: 110,
                  left: 20,
                  child: SizedBox(
                    width: 250,
                    child: Text(
                      'this is text that im using to check the content',
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ))
            ],
          ),
        ),
        //TODO 5/6/2022: How to achieve ellipse text behavior & what is overflow property?
        //TODO 5/6/2022: Try using FittedBox
      ],
    );
  }

  void gotoDetailsPage(int index, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return NewsDetails(isOnline: isOnline);
    },settings: RouteSettings(name: 'send',arguments:newsData,)));
    // NewsDetails.routeName, arguments: );
  }
}
