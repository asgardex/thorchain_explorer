import 'package:hooks_riverpod/hooks_riverpod.dart';

enum ExplorerThemeMode { DARK, LIGHT }

class ThemeState {
  ThemeState(this.mode);

  final ExplorerThemeMode mode;
}

class ThemeProvider extends StateNotifier<ThemeState> {
  ThemeProvider(themeState) : super(themeState);

  toggle() {
    state = state.mode == ExplorerThemeMode.DARK
        ? ThemeState(ExplorerThemeMode.LIGHT)
        : ThemeState(ExplorerThemeMode.DARK);
  }
}
