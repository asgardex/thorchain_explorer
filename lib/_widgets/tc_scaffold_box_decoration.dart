import 'package:flutter/material.dart';

BoxDecoration tcScaffoldBoxDecoration(BuildContext context) => BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
          0.0,
          0.6,
          0.9
        ],
            colors: [
          Colors.blueGrey[900],
          Colors.grey[900],
          Colors.grey[900],
        ]));
