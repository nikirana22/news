import 'package:flutter/material.dart';

class Tranding extends StatelessWidget {
  const Tranding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      height: 80,
      color: Colors.white,
      child: Row(
        children: [
          const Text(
            'trending ',

            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold
            ),
          ),
          TextButton(
            onPressed: () {},
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
                MaterialStateProperty.all(Colors.red)),
          )
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }
}
