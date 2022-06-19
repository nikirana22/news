import 'package:flutter/material.dart';

import '../screens/Home.dart';

class _Pages{
  int selectedPos = 0;
  List<Widget> pageList = [ Home(),//todo Is this write
    Container(
      color: Colors.white60,
    ),
    Container(
      color: Colors.purple,
    ),
    Container(
      color: Colors.yellow,
    )];
}
class PageChangeHelper with ChangeNotifier{
  _Pages pages=_Pages();

  void pagechanged(int position){
    pages.selectedPos=position;
    notifyListeners();
  }
}