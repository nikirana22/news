import 'package:flutter/material.dart';

class DetailsNewsTitle extends StatelessWidget {
  final String titleData;
  final TextStyle? textStyle;
   DetailsNewsTitle({required this.titleData,this.textStyle,Key? key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.all(20),
      child: Text(
        titleData.toString(),
        style:textStyle
      ),
    );
  }
}
