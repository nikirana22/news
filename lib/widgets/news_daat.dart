import 'package:flutter/material.dart';

class NewsData extends StatelessWidget {

  String image;
  String title;
  int index;
  String author;
  Function imageClick;

  NewsData(
      {Key? key,
      required this.index,
      required this.image,
      required this.title,
      required this.author,
      required this.imageClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String autherName=author.length>15?author.substring(0,10):author;
    return Column(
      children: [
        InkWell(
          onTap: () => imageClick(index, context),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  image,
                  height: 190,
                  fit: BoxFit.fill,
                ),
              ),
               Positioned(
                  top: 40,
                  left: 170,
                  child: Text(
                    autherName,
                    style: const TextStyle(fontSize: 15, color: Colors.white),
                  )),
              const Positioned(
                  top: 110,
                  left: 20,
                  child: SizedBox(
                    width: 250,
                    child: Text(
                      'this is text that im using to check the content',
                      style: TextStyle(fontSize: 23, color: Colors.white),
                    ),
                  ))
            ],
          ),
        ),
        //TODO 5/6/2022: How to achieve ellipse text behavior & what is overflow property?
        //TODO 5/6/2022: Try using FittedBox

      ],
    );
  }
}
