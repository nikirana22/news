import 'package:news/entity/dao_data.dart';

class DaoParser {
  static const String _authorKey = 'author';
  static const String _title = 'title';
  static const String _description = 'description';
  static const String _url = 'url';
  static const String _urlToImage = 'urlToImage';
  static const String _publishedAt = 'publishedAt';
  static const String _content = 'content';

  static DataDao sendData(Map map) {
    return DataDao(
        author: map[_authorKey] as String,
        title: map[_title],
        description: map[_description],
        url: map[_url],
        urlToImage: map[_urlToImage],
        publishedAt: map[_publishedAt],
        content: map[_content]);
  }
}
