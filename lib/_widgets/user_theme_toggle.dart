import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:thorchain_explorer/_providers/_state.dart';
import 'package:thorchain_explorer/_providers/user_theme_notifier.dart';

class UserThemeToggle extends HookWidget {
  @override
  Widget build(BuildContext context) {
    UserThemeNotifier notifier = useProvider(userThemeProvider.notifier);
    ThemeMode mode = useProvider(userThemeProvider);

    return Container(
      child: Row(
        children: [
          IconButton(
              icon: Icon(
                Icons.wb_sunny,
                color: mode == ThemeMode.light ? Colors.white : Colors.grey,
              ),
              onPressed: () {
                notifier.toggle(ThemeMode.light);
              }),
          Text(
            '/',
            style: TextStyle(color: Colors.white),
          ),
          IconButton(
              icon: Icon(
                Icons.nights_stay,
                color: mode == ThemeMode.dark ? Colors.white : Colors.grey,
              ),
              onPressed: () {
                notifier.toggle(ThemeMode.dark);
              }),
        ],
      ),
    );
  }
}
