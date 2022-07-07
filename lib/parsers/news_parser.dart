import '../entity/dao_data.dart';
import '../providers/news.dart';

class NewsParser {
  static int id = 0;
  static const String authorKey = 'author';
  static const String title = 'title';
  static const String description = 'description';
  static const String url = 'url';
  static const String urlToImage = 'urlToImage';
  static const String publishedAt = 'publishedAt';
  static const String content = 'content';


  static Map<String, List<News>>saveMap = {};

  static News parseNews(Map<String, Object> jsonMap) {
    id++;

    return News(
        id: id,
        author: jsonMap[authorKey] as String,
        title: jsonMap[title] as String,
        description: jsonMap[description] as String,
        url: jsonMap[url] as String,
        urlToImage: jsonMap[urlToImage] == null
            ? 'https://cdn.vectorstock.com/i/1000x1000/35/52/placeholder-rgb-color-icon-vector-32173552.webp'
            : jsonMap[urlToImage] as String,
        publishedAt: jsonMap[publishedAt] as String,
        content: jsonMap[content] as String);
  }

  static List<News> parseArticles(List articlesList, String category) {
    List<News> list = [];
    if (saveMap.containsKey(category)) {
      list = saveMap[category] as List<News>;
    }
    else {
      list = articlesList.map((e) => parseNews(e)).toList();
      saveMap.putIfAbsent(category, () => list);
    }
    return list;
  }

  static List<News> change(List<DataDao> list) {
    return list
        .map((e) =>
        News(
            id: 0000,
            author: e.author,
            title: e.title,
            description: e.description,
            url: e.url,
            urlToImage: e.urlToImage,
            publishedAt: e.publishedAt,
            content: e.content))
        .toList();
  }
  //todo can we make this class as singleton
  static void removeFavorite(int id) {
    int? index;
    saveMap.forEach((key, value) {
      int ind=value.indexWhere((element) => element.id==id);
      if(ind!=-1){
        index=ind;
        (saveMap[key]as List<News>)[index!].isFavorite=false;
      }
      });

  }

}
