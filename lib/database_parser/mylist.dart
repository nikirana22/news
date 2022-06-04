
import 'package:news/entity/dao_data.dart';

class MyList{

  List<DataDao>? myList;

  set ourList(List<DataDao> list){
    myList=list;
  }
  List<DataDao>?get  getList=>myList;

}