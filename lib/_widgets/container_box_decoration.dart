import 'package:flutter/material.dart';

BoxDecoration containerBoxDecoration(BuildContext context, ThemeMode mode) =>
    BoxDecoration(
      border: (mode == ThemeMode.dark)

          // dark mode
          ? MediaQuery.of(context).size.width < 900

              // mobile - only border on top and bottom
              ? Border.symmetric(
                  horizontal: BorderSide(color: Colors.blueGrey[800], width: 1),
                )

              // desktop - border on all sides
              : Border.all(color: Colors.blueGrey[800], width: 1)

          // light mode no border
          : null,
      borderRadius: MediaQuery.of(context).size.width < 900
          ? null
          : BorderRadius.circular(4),
      color: Theme.of(context).cardColor,
    );
