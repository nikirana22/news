import 'package:flutter/material.dart';

import '../screens/Home.dart';

class _Pages{
  // List<Widget> pageList = [ Home(),//todo Is this write
  //   Container(
  //     color: Colors.white60,
  //   ),
  //   Container(
  //     color: Colors.purple,
  //   ),
  //   Container(
  //     color: Colors.yellow,
  //   )];
}
class PageChangeHelper with ChangeNotifier{
  // _Pages pages=_Pages();
  int selectedPos = 0;


  void pagechanged(int position){
    selectedPos=position;
    // pages.selectedPos=position;
    notifyListeners();
  }
}