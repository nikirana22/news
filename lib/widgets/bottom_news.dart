import 'package:flutter/material.dart';
import '../models/articles.dart';

class BottomNews extends StatelessWidget {
  Articles? articles;

  BottomNews({Key? key, required this.articles}) : super(key: key);

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
        padding: const EdgeInsets.only(
            left: 20, right: 20, bottom: 15),
        width: double.infinity,
        height: 228,
        child: ListView.builder(
            itemCount: articles?.newsList.length,
            itemBuilder: (context, index) {
              return Container(
                  margin:const  EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: articles?.newsList[index]
                              .urlToImage !=
                              null
                              ? Image.network(
                              articles!
                                  .newsList[index].urlToImage
                                  .toString(),
                              width: 70,
                              height: 70,
                              fit: BoxFit.fill)
                              : const SizedBox(
                            height: 70,
                            width: 70,
                          )),
                      Column(
                        children: [
                          SizedBox(
                              width: 200,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, top: 2),
                                child: Text(
                                  articles!.newsList[index].title
                                      .toString(),
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 15),
                                ),
                              )),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            articles!.newsList[index].publishedAt
                                .toString(),
                            style: const TextStyle(fontSize: 7),
                          ),
                        ],
                      )
                    ],
                  ));
            }));
  }
}
