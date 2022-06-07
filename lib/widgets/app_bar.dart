import 'package:flutter/material.dart';

class Appbar extends StatelessWidget with PreferredSizeWidget {
  List categoryList;
  Function categoryChangeButtonClick;
  Appbar(
      {required this.categoryList, required this.categoryChangeButtonClick, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
            padding: EdgeInsets.only(top: 4, left: 10),
            child: Icon(
              Icons.menu,
              color: Colors.black,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.supervised_user_circle,
                  color: Colors.grey,
                  size: 35,
                )),
          ),
        ],
        bottom: TabBar(
          labelStyle:const TextStyle(fontSize: 25),
          unselectedLabelStyle:const TextStyle(fontSize: 15),
          tabs: [
            Tab(text: categoryList[0].toString()),
            Tab(text: categoryList[1].toString()),
            Tab(text: categoryList[2].toString()),
          ],
          onTap: (index) => categoryChangeButtonClick(index),
          labelColor: const Color.fromRGBO(182, 105, 122, 1),
          indicatorColor: const Color.fromRGBO(182, 105, 122, 1),
          unselectedLabelColor: Colors.black26,
        ));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>const Size.fromHeight(90);
}