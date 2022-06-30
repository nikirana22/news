import 'dart:io';
import 'package:flutter/material.dart';
import '../providers/news.dart';
import '../screens/detail_screen.dart';

class TopNews extends StatelessWidget {
  // int index;

  final News newsData;
  final bool isOnline;

  const TopNews({
    Key? key,
    required this.isOnline,
    required this.newsData,
    // required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size =MediaQuery.of(context).size;
    double height=size.height;
    double width =size.width;
    return Column(
      children: [
        InkWell(
          onTap: () => gotoDetailsPage(/*index,*/ context),
          child: Stack(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: isOnline
                      ? FadeInImage(
                          height: height*0.26,
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
                    height: height*0.26,
                    fit: BoxFit.fill,

                      placeholder:const AssetImage('placeholder.png') ,
                              image: FileImage(
                                  File(newsData.urlToImage.toString())),
                              )

                  ),
              Positioned(
                  top: height*0.05,
                  right: width*0.08,
                  child: Text(
                    newsData.author.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  )),
              Positioned(
                  top: height*0.15,
                  left: 20,
                  child: SizedBox(
                    width: width*0.7,
                    child: Text(
                      newsData.title.toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:const TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ))
            ],
          ),
        ),

      ],
    );
  }

  void gotoDetailsPage(/*int index,*/ BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return NewsDetails(isOnline: isOnline);
    },settings: RouteSettings(name: 'send',arguments:newsData,)));
    // NewsDetails.routeName, arguments: );
  }
}
