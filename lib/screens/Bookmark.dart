import 'package:flutter/material.dart';

class Bookmark extends StatelessWidget {
  const Bookmark();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.cyanAccent,
        height: MediaQuery.of(context).size.height * 0.8,
        //     child: ListView.builder(
        //     itemCount: value.list?.length,
        // itemBuilder: (context, index) {
        // return ClipRRect(
        // child:value.list?.length==0
        // ? const Center(
        // child: Text(
        // 'No Data Found',
        // style: TextStyle(
        // fontWeight: FontWeight.bold, fontSize: 40
        // ),
        // ))
        //     : Image.network(value.list![index].urlToImage.toString())
        // );
        // }
        // );
        //     },
      ),
    );
  }
}
