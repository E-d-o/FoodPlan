import 'package:flutter/material.dart';

class HomepageManager extends ChangeNotifier {
  HomepageManager() {
    scrollController.addListener(_scrollListener);
  }

  bool isFloatingButtonVisible = false;
  ScrollController scrollController = ScrollController();

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 150),
      curve: Curves.easeIn,
    );
  }

  void _scrollListener() {
    int scrollTresh = 200;
    bool shouldShow = scrollController.offset > scrollTresh;

    if (shouldShow != isFloatingButtonVisible) {
      isFloatingButtonVisible = !isFloatingButtonVisible;
      notifyListeners();
    }
  }
}
