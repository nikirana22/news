import 'package:flutter/material.dart';
class NewsDetailsAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 35),
      // margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.facebook,
            size: 15,
            color: Colors.white60,
          ),
          Icon(
            Icons.whatsapp,
            color: Colors.white60,
            size: 15,
          ),
          Icon(
            Icons.email,
            color: Colors.white60,
            size: 15,
          ),
          Icon(
            Icons.share,
            color: Colors.white60,
            size: 15,
          ),
          Icon(
            Icons.favorite,
            size: 15,
            color: Colors.white60,
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(80);
}
