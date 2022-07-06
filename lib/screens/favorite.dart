import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news.dart';

class Favorite extends StatelessWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<News>? newsList=getNewsList(context);
    Size size = MediaQuery.of(context).size;
    double height = size.height;
    double width = size.width;
    return Scaffold(
      body:newsList.isNotEmpty?
      Container(
        height: height,
        width: width,
        color: Colors.black,
        child: ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (_, index) {
              return Card(
                // color: Colors.pink,
                // color: Colors.white,
                  margin: EdgeInsets.symmetric(
                      horizontal: width * 0.05,
                      vertical: height * 0.01),
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 10,
                        bottom: 4,
                        left: 4,right: 2),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        FadeInImage(
                            width: width * 0.3,
                            height: height * 0.22,
                            fit: BoxFit.cover,
                            placeholder:
                            const AssetImage('assets/placeholder.png'),
                            image: NetworkImage(
                                newsList[index].urlToImage.toString())),
                        const SizedBox(width: 6,),
                        SizedBox(
                          // color: Colors.red,
                            width: width*0.55,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(newsList[index].description.toString(),maxLines: 4,overflow: TextOverflow.ellipsis,style:const TextStyle(fontSize: 13),),
                                const SizedBox(height: 6,),
                                Text(newsList[index].author.toString()),
                                const SizedBox(height: 6,),
                                Text(newsList[index].title.toString(),
                                  maxLines: 3,overflow: TextOverflow.ellipsis,),
                                Align(
                                    child:IconButton(onPressed:(){
                                      Provider.of<Articles>(context,listen: false).removeFavoriteNews(index);
                                    },icon:const Icon(Icons.favorite,color: Colors.red,)),
                                    alignment: Alignment.centerRight
                                )
                              ],
                            )
                        )
                      ],
                    ),
                  ));
            }),
      ):const Center(
        child: Text(
          'NO Favorite News Found',style: TextStyle(fontSize:30,
            color: Colors.yellow
        ),
        ),
      ),
    );
  }

  List<News> getNewsList(BuildContext context) {
    Iterable<News> iterable = Provider.of<Articles>(context,)
        .newsList
        .where((element) => element.isFavorite == true);
    List<News> newslist = iterable.map((e) {
      return e;
    }).toList();
    print('how many items in newslist  ${newslist.length}');
    return newslist;
  }
}
