import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  VoidCallback onContinueButtonClick;

  CustomAppBar({Key? key, required this.onContinueButtonClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return Container(
      color: Colors.white,
      height: 50,
      margin: const EdgeInsets.only(top: 28),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
              padding: EdgeInsets.only(top: 4, left: 10),
              child: Icon(Icons.menu)),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: IconButton(
                onPressed: onContinueButtonClick,
                // Navigator.pushNamed(context, CategoryPage.DATA);,
                icon: const Icon(
                  Icons.supervised_user_circle,
                  color: Colors.grey,
                  size: 35,
                )),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(75);
}
