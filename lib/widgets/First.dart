// import 'package:flutter/material.dart';
//
// class DetailsNewsDesc extends StatelessWidget {
//   final String _description;
//   final String _descriptionData;
//
//  const DetailsNewsDesc(this._description, this._descriptionData,Key? key):super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return
//       // Container(
//       //   width: double.infinity,
//       //   decoration: BoxDecoration(
//       //       borderRadius: BorderRadius.circular(30),
//       //       color: Colors.white,
//       //       border: Border.all(color: Colors.orangeAccent, width: 5),
//       //       boxShadow: const [
//       //         BoxShadow(
//       //             color: Colors.black,
//       //             blurRadius: 5,
//       //             spreadRadius: 1,
//       //             offset: Offset(0, 5))
//       //       ]),
//       //   padding:const EdgeInsets.all(20),
//       //   margin:const EdgeInsets.all(9),
//       //   child: Column(
//       Column(
//           children: [
//             Text(
//               _description,
//               style: const TextStyle(
//                   fontSize: 30,
//                   color: Colors.greenAccent,
//                   fontWeight: FontWeight.bold),
//             ),
//             Padding(
//               padding:const EdgeInsets.symmetric(horizontal: 30),
//               child: Text(
//                 _descriptionData,
//                 style: Theme.of(context).textTheme.headline3,
//               ),
//             )
//           ],
//         );
//   }
// }