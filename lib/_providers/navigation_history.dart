//
//
// import 'package:riverpod/riverpod.dart';
//
// // class NavigationHistory {
// //   List<String> paths;
// //
// //   NavigationHistory(this.paths);
// // }
//
// class NavigationHistoryHandler extends StateNotifier<List<String>> {
//
//   NavigationHistoryHandler([List<String> initialHistory]) : super(initialHistory ?? []);
//
//   pop() {
//     final history = state;
//     if (history.length > 0) {
//       history.removeLast();
//     }
//     state = history;
//
//     // if (state.length > 0) {
//     //   print('navigation state is: ');
//     //   state.forEach((path) {
//     //     print(path);
//     //   });
//     // }
//   }
//
//   add(String path) {
//     if (state.length > 0 && state[state.length - 1] != path) {
//       state = [...state, path];
//     } else {
//       state = [path];
//     }
//
//     print('ADD: ');
//     state.forEach((path) {
//       print(path);
//     });
//     print('=======================');
//   }
//
//   list() {
//     print('listing paths');
//     state.forEach((element) => print(element));
//     print('==============');
//   }
//
// }
