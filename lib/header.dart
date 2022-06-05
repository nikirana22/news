import 'package:flutter/material.dart';
import 'package:news/models/news.dart';

class Header extends StatelessWidget {
  final String data;

  //TODO 5/10/2022: refactor this
  final Function onClick;
  int index;
  List<News> favoriteNewsList;

  Header(
      {Key? key,
      required this.data,
      required this.onClick,
      required this.favoriteNewsList,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => onClick(data, index),
      child: Center(
        child: Text(
          data,
          style: const TextStyle(color: Colors.red, fontSize: 30),
        ),
      ),
    );
  }
}
