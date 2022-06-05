import 'package:news/entity/dao_data.dart';
import 'package:news/models/articles.dart';

import '../models/news.dart';

class NewsParser {
  // static Dao? datadao;
  // static DataDao? dao;
  static const String _authorKey = 'author';
  static const String _title = 'title';
  static const String _description = 'description';
  static const String _url = 'url';
  static const String _urlToImage = 'urlToImage';
  static const String _publishedAt = 'publishedAt';
  static const String _content = 'content';

  static News parseNews(Map<String, Object> jsonMap) {
     // dao= DataDao(
     //    author: jsonMap[_authorKey] as String,
     //    title: jsonMap[_title] as String,
     //    description: jsonMap[_description] as String,
     //    url: jsonMap[_url] as String,
     //    urlToImage: jsonMap[_urlToImage] as String,
     //    publishedAt: jsonMap[_publishedAt] as String,
     //    content: jsonMap[_content] as String);

    return News(
        author: jsonMap[_authorKey] as String,
        title: jsonMap[_title] as String,
        description: jsonMap[_description] as String,
        url: jsonMap[_url] as String,
        urlToImage: jsonMap[_urlToImage] as String,
        publishedAt: jsonMap[_publishedAt] as String,
        content: jsonMap[_content] as String);
  }

  static Articles parseArticles(List articlesList) {
    Articles articles = Articles();
    articles.setNewsList = articlesList.map((e) => parseNews(e)).toList();
    return articles;
  }

  static Articles change(List<DataDao> list) {
    Articles articles = Articles();
    articles.setNewsList = list.map((e) {
      News news = News(
          author: e.author,
          title: e.title,
          description: e.description,
          url: e.url,
          urlToImage: e.urlToImage,
          publishedAt: e.publishedAt,
          content: e.content);
      return news;
    }).toList();
    return articles;
  }
}
