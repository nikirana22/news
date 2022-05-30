import 'package:flutter/material.dart';

class DetailsNewsTitle extends StatelessWidget {
  final String _titleData;
  final TextStyle? textStyle;
  DetailsNewsTitle( this._titleData,this.textStyle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Text(
        _titleData.toString(),
        style:textStyle
      ),
    );
  }
}
