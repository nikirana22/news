import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../providers/recently_watch_news.dart';
import '../providers/news.dart';

class RecentlyWatch extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    List<News> ;
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    RecentlyWatchNews recentlyWatch=Provider.of<RecentlyWatchNews>(context,listen: false);
    List<News> recentlyWatchNews=recentlyWatch.getRecentlyWatchNews();
    return Scaffold(
      backgroundColor: Colors.white10,
      body: SafeArea(
        child: recentlyWatchNews.isNotEmpty
            ? SizedBox(
            child: ListView.builder(
              itemCount: recentlyWatchNews.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: double.infinity,
                  height: height * 0.5,
                  color: Colors.white,
                  margin: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image(
                        height: height * 0.25, width: double.infinity,
                        fit: BoxFit.cover,
                        // image:  NetworkImage(
                        image: NetworkImage(
                            recentlyWatchNews[index].urlToImage.toString()),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        recentlyWatchNews[index].author.toString(),
                        style: TextStyle(fontSize: 25, color: Colors.brown),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          recentlyWatchNews[index].title.toString(),
                          style: TextStyle(fontSize: 15),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          recentlyWatchNews[index].description.toString(),
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.5)),
                          maxLines: 4,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ))
            : const Center(
            child: Text(
              'No Watched news found',
              style: TextStyle(fontSize: 30, color: Colors.white),
            )),
      ),
    );

    //   Selector<RecentlyWatchNews,int>(
    //     selector: (_,news){
    //       recentlyWatch=news;
    //       return news.newsLength;
    //     },
    //     builder: (_,newslist,child){
    //
    //   // RecentlyWatchNews recentlyWatch=Provider.of<RecentlyWatchNews>(context,listen: false);
    //   List<News> recentlyWatchNews=recentlyWatch!.recentlyWatchNews;
    //   return
    //
    // }, );
  }
}

