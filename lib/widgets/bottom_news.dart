import 'dart:io';
import 'package:flutter/material.dart';
import '../providers/news.dart';

class BottomNews extends StatelessWidget {
  List<News> articles;
  bool isOnline;

  BottomNews(
      {Key? key, required this.articles,
        required this.isOnline,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
        width: double.infinity,
        height: 238,
        child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                  //todo check this ---------->how can we solve null url
                  child:isOnline==true?
                             Image.network(
                                      articles[index].urlToImage.toString(),
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill)
                                  : Image.file(
                                      File(
                                          articles[index].urlToImage.toString()),
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill)
                              ),
                      Column(
                        children: [
                          SizedBox(
                              width: 200,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, top: 2),
                                child: Text(
                                  articles[index].title.toString(),
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 15),
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            articles[index].publishedAt.toString(),
                            style: const TextStyle(fontSize: 7),
                          ),
                        ],
                      )
                    ],
                  ));
            }));
  }
}
