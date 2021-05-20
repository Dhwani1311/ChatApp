//
// import 'package:flutter/material.dart';
//
// InputDecoration textFiledDecotaion(String hintText, IconData icon) {
//   return InputDecoration(
//     hintText: hintText,
//     prefixIcon: Icon(
//       icon,
//       color: Colors.black38,
//     ),
//     border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(45),
//         borderSide: BorderSide(width: 1, color: Colors.black87)),
//   );
// }
//
// class InputButton extends StatelessWidget {
//   final Widget child;
//   final Function onPressed;
//   final Color color;
//
//   InputButton(
//       {@required this.onPressed, @required this.child, @required this.color});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialButton(
//       color: color,
//       onPressed: onPressed,
//       child: Ink(
//         width: MediaQuery.of(context).size.width / 1.5,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30.0),
//         ),
//         child: Container(
//             constraints: BoxConstraints(maxWidth: 200.0, minHeight: 50.0),
//             alignment: Alignment.center,
//             child: child),
//       ),
//       splashColor: Colors.black12,
//       padding: EdgeInsets.all(0),
//       shape: RoundedRectangleBorder(
//         borderRadius: new BorderRadius.circular(32.0),
//       ),
//     );
//   }
// }
