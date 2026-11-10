import 'package:flutter/material.dart';

class MainShellProvider with ChangeNotifier {
  static const homeIndex = 0;

  int _currentIndex = homeIndex;
  int get currentIndex => _currentIndex;

  // A tab is built the first time it is selected and kept alive afterwards.
  final Set<int> _visited = {homeIndex};
  bool isVisited(int index) => _visited.contains(index);

  void selectTab(int index) {
    if (index == _currentIndex) {
      return;
    }
    _currentIndex = index;
    _visited.add(index);
    notifyListeners();
  }

  // Called by a new shell from initState, before anything listens, so it does
  // not notify. The previous shell is gone on logout / session end, so a fresh
  // login always starts on Home with no other tab built.
  void reset() {
    _currentIndex = homeIndex;
    _visited
      ..clear()
      ..add(homeIndex);
  }
}
