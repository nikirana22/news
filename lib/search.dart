import 'package:flutter/material.dart';

class _Search extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.black12, borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          const Icon(Icons.search),
          Container(
            padding: const EdgeInsets.only(left: 20),
            width: 250,
            child: const TextField(
              decoration:
                  InputDecoration(hintText: 'Search', border: InputBorder.none),
            ),
          )
        ],
      ),
    );
  }
}
