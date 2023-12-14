import 'package:flutter/material.dart';

class MovieProvider with ChangeNotifier {
  List _trending = [];

  List get trending => _trending;

  void updateTrending(List newTrending) {
    _trending = newTrending;
    notifyListeners();
  }
}
