import 'dart:async';
import 'package:floor/floor.dart';
import 'package:news/dao/dao.dart';
import '../entity/dao_data.dart';
import 'package:sqflite/sqflite.dart'as sqflite;

part "dao_database.g.dart";

@Database(version:  1, entities: [DataDao])
abstract class DaoDatabase extends FloorDatabase{

  Dao get datadao;


}