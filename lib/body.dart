import 'package:flutter/material.dart';

import 'main.dart';

class Body extends StatelessWidget {
  String image;
  String title;
  double imageHeight;
  bool ?fixImage;
  int index;

  Function imageClick;



  // String desc;
  Body({required this.index,required this.image, required this.title, required this.imageHeight,required this.imageClick});

  @override
  Widget build(BuildContext context) {
    String titles = title.substring(0, 33);
    // print('check ${MediaQuery
    //     .of(context)
    //     .size
    //     .width * 0.95}');

    return SingleChildScrollView(
      child: Container(
        // color: Colors.green,
        child: Column(

          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        InkWell(
          onTap:()=> imageClick(index),
          child: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            image,
            height:imageHeight,
            width: 500,
            // height: 350,
            fit:Second.checkScreenMode==Orientation.landscape? BoxFit.fitWidth:BoxFit.fitHeight,
          ),
          ),
        ),
            //TODO 5/6/2022: How to acheive ellipse text behavior & what is overflow property?
            //TODO 5/6/2022: Try using FittedBox
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                titles,
                // maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            // Text(titiles)
          ],
        ),
      ),
    );
  }
}
