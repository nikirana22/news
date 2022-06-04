import 'package:flutter/material.dart';

class Tranding extends StatelessWidget {
  Tranding({required this.moreButtonClick,Key? key}) : super(key: key);

  VoidCallback moreButtonClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 80,
      color: Colors.white,
      child: Row(
        children: [
          // Icon(Icons.point)
          const Text(
            'trending ',

            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold
            ),
          ),
          TextButton(
            onPressed: moreButtonClick,
            child: const Text(
              'More',
              style: TextStyle(color: Colors.white),
            ),
            style: ButtonStyle(
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(30))),
                backgroundColor:
                MaterialStateProperty.all(const Color.fromRGBO(215, 79, 103, 1))),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
