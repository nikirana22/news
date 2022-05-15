import 'package:flutter/material.dart';

class FirstCont extends StatelessWidget {
  Widget widget1;
  Widget widget2;
  FirstCont(this.widget1, this.widget2);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
            border: Border.all(color: Colors.orangeAccent, width: 5),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black,
                  blurRadius: 5,
                  spreadRadius: 1,
                  offset: Offset(0, 5))
            ]),
        padding: EdgeInsets.all(20),
        margin: EdgeInsets.all(9),
        child: Column(
          children: [widget1, widget2],
        ));
  }
}
