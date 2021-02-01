// import 'package:flutter/material.dart';
//
// class AbridgeText extends StatelessWidget {
//
//   final int prefixLength;
//   final int suffixLength;
//   final String text;
//   final TextStyle textStyle;
//
//   AbridgeText(this.text, {this.prefixLength = 4, this.suffixLength = 4, this.textStyle});
//
//   @override
//   Widget build(BuildContext context) {
//     return SelectableText(
//       '${text.substring(0, prefixLength)}...${text.substring(text.length - suffixLength, text.length)}',
//       // style: TextStyle(
//       //   color: textColor ?? Theme.of(context).textTheme.
//       // ),
//       style: textStyle ?? Theme.of(context).textTheme.bodyText1
//     );
//   }
// }
