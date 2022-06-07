import '../entity/dao_data.dart';
import '../providers/news.dart';

class NewsParser {
  static const String authorKey = 'author';
  static const String title = 'title';
  static const String description = 'description';
  static const String url = 'url';
  static const String urlToImage = 'urlToImage';
  static const String publishedAt = 'publishedAt';
  static const String content = 'content';

  static News parseNews(Map<String, Object> jsonMap) {
    return News(
        author: jsonMap[authorKey] as String,
        title: jsonMap[title] as String,
        description: jsonMap[description] as String,
        url: jsonMap[url] as String,
        urlToImage: jsonMap[urlToImage] as String,
        publishedAt: jsonMap[publishedAt] as String,
        content: jsonMap[content] as String);
  }

  static List<News> parseArticles(List articlesList) {
    return articlesList.map((e) => parseNews(e)).toList();
  }

  static List<News> change(List<DataDao> list) {
    return list
        .map((e) => News(
            author: e.author,
            title: e.title,
            description: e.description,
            url: e.url,
            urlToImage: e.urlToImage,
            publishedAt: e.publishedAt,
            content: e.content))
        .toList();
  }
}
