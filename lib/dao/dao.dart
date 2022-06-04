import 'package:floor/floor.dart';
import '../entity/dao_data.dart';
//
@dao
abstract class Dao{
  @insert
  Future<void> addData(DataDao dataDao);


  @Query('SELECT * FROM apidata')
  Future<List<DataDao>> getData();

}