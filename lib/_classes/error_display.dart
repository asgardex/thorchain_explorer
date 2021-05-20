import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_widgets/container_box_decoration.dart';

class ErrorDisplay extends HookWidget {
  final String header;
  final String subHeader;
  final List<String> instructions;

  ErrorDisplay(
      {this.header = 'Sorry, something went wrong',
      required this.subHeader,
      this.instructions = const []});

  @override
  Widget build(BuildContext context) {
    final ThemeMode mode = useProvider(userThemeProvider);

    return Material(
      elevation: 1,
      child: Container(
        decoration: containerBoxDecoration(context, mode),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 72),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off,
                    size: 48,
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        header,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: mode == ThemeMode.dark
                      ? Colors.blueGrey[900]
                      : Colors.blueGrey[100],
                ),
                child: Row(
                  children: [
                    Icon(Icons.info),
                    SizedBox(
                      width: 8,
                    ),
                    Flexible(
                      child: SelectableText(subHeader),
                    )
                  ],
                ),
              ),
            ),
            (instructions.length > 0)
                ? Container(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                    child: Column(
                        children: instructions
                            .map((e) => Container(
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: SelectableText(e),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ],
                                  ),
                                ))
                            .toList()),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
