//todo: refresh function in app
import 'package:floor/floor.dart';

@Entity(tableName: 'apidata')
class DataDao {
  @PrimaryKey(autoGenerate: true)
  int? id;
  String? author;
  String? title;
  String? description;
  String? url;
  String? urlToImage;
  String? publishedAt;
  String? content;

  DataDao(
      {required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});

  @override
  String toString() {
    return 'id =$id ,'
        ' author = $author ,'
        ' title=$title ,'
        ' description = $description ,'
        ' url = $url ,'
        ' urlToImage = $urlToImage , '
        'publishedAt = $publishedAt , '
        'content = $content';
  }
}
