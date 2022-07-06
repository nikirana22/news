import 'package:flutter/material.dart';

class Tranding extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    double height=size.height;
    double width =size.width;
    return Container(

      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: height*0.1,
      color: Colors.white,
      width: double.infinity,
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
            onPressed: (){},
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
