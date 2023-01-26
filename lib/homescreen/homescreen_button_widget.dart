// import 'package:flutter/material.dart';
//
// class homescreen_button_widget extends StatelessWidget {
//   const homescreen_button_widget({
//     Key? key,
//     required this.title,
//     required this.path,
//     required this.icon,
//   }) : super(key: key);
//
//   final String title;
//   final String path;
//   final Icon icon;
//
//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: GestureDetector(
//         child: Container(
//             margin: const EdgeInsets.only(right: 5),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(10),
//                   topRight: Radius.circular(10),
//                   bottomLeft: Radius.circular(10),
//                   bottomRight: Radius.circular(10)),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.5),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: Offset(0, 3), // changes position of shadow
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Transform.rotate(angle: 6, child: icon),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Text(
//                   title,
//                   style: TextStyle(color: Colors.blueAccent),
//                 )
//               ],
//             )),
//         onTap: () {
//           Navigator.pushNamed(context, '/$path');
//         },
//       ),
//     );
//   }
// }
