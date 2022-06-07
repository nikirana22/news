import 'dart:async';
import 'dart:isolate';

import 'package:floor/floor.dart';
import 'package:news/dao/dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../entity/dao_data.dart';

part "dao_database.g.dart";

@Database(version: 1, entities: [DataDao])
abstract class DaoDatabase extends FloorDatabase {
  Dao get datadao;
}
