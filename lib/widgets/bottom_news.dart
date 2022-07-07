import 'dart:io';
import 'package:flutter/material.dart';
import '../providers/news.dart';

class BottomNews extends StatelessWidget {
  final List<News> articles;
  final bool isOnline;

  const BottomNews({
    Key? key,
    required this.articles,
    required this.isOnline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(40),
            bottomRight: Radius.circular(40),
          ),
        ),
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 15, top: 10),
        width: double.infinity,
        height: height * 0.35,
        child: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Container(
                  height: height * 0.1,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: isOnline == true
                              ? Image.network(
                                  articles[index].urlToImage.toString(),
                                  width: width * 0.2,
                                  height: height * 0.095,
                                  fit: BoxFit.fill)
                              : Image.file(
                                  File(articles[index].urlToImage.toString()),
                              width: width * 0.2,
                              height: height * 0.095,
                                  fit: BoxFit.fill)),
                      Container(
                        height: height*0.1,
                        width: width*0.66,
                        alignment: Alignment.center,
                        padding:const EdgeInsets.symmetric(horizontal: 3),

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            SizedBox(
                                width: width*0.8,
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
                        ),
                      )
                    ],
                  ));
            }));
  }
}
