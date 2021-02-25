import 'package:flutter/material.dart';

BoxDecoration containerBoxDecoration(BuildContext context) => BoxDecoration(
      border: (MediaQuery.of(context).platformBrightness == Brightness.dark)
          ? Border.all(color: Colors.blueGrey[800], width: 1)
          : null,
      borderRadius: BorderRadius.circular(4.0),
      color: Theme.of(context).cardColor,
    );
