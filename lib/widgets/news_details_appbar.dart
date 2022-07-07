import 'package:flutter/material.dart';

class NewsDetailsAppBar extends StatelessWidget with PreferredSizeWidget {
  const NewsDetailsAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double height=size.height;
    return Container(
      height: height*0.085,
      padding: const EdgeInsets.symmetric(horizontal: 35),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          icon(Icons.facebook,),
          icon(Icons.whatsapp,),
          icon(Icons.email,),
          icon(Icons.share,),
          icon(Icons.favorite,),

          // Icon(
          //   size: 15,
          //   color: Colors.white60,
          // ),
          // Icon(
          //   Icons.whatsapp,
          //   color: Colors.white60,
          //   size: 15,
          // ),
          // Icon(
          //   Icons.email,
          //   color: Colors.white60,
          //   size: 15,
          // ),
          // Icon(
          //   Icons.share,
          //   color: Colors.white60,
          //   size: 15,
          // ),
          // Icon(
          //   Icons.favorite,
          //   size: 15,
          //   color: Colors.white60,
          // )
        ],
      ),
    );
  }
  Widget icon(IconData iconData){
    return Icon(
      iconData,
      size: 15,
      color: Colors.white60,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(80);
}
