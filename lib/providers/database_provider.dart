import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import '../dao/dao.dart';
import '../database/dao_database.dart';
import '../entity/dao_data.dart';
import '../parsers/news_parser.dart';
import '../providers/news.dart';


class DatabaseProvider with ChangeNotifier {
  List<News> _articlesDatabae = [];
  final CacheManager _cacheManager = DefaultCacheManager();
  File? imageFile;

  List<News> get articlesDatabase {
    return [..._articlesDatabae];
  }

  Future<void> deleteDb() async {
    Dao dao = await getDao();
    dao.clearDb();
  }

  Future<Dao> getDao() async {
    DaoDatabase database =
        await $FloorDaoDatabase.databaseBuilder('apidata').build();
    Dao dao = database.datadao;
    return dao;
  }

  Future<void> getDataFromDatabase() async {
    Dao dao = await getDao();
    List<DataDao> list = await dao.getData();
    if (list.isNotEmpty) {
      _articlesDatabae = NewsParser.change(list);
    }
  }

  Future<void> clearAndUpdateDB() async {
    await deleteDb();
  }

  void databaseDataAdded(List<News> list) async {
    await clearAndUpdateDB();
    Dao dao = await getDao();
    for (News e in list) {
      imageFile = await _cacheManager.getSingleFile(e.urlToImage.toString());
      dao.addData(DataDao(
          author: e.author,
          title: e.title,
          description: e.description,
          url: e.url,
          urlToImage: imageFile?.path,
          publishedAt: e.publishedAt,
          content: e.content));
    }
  }
}
