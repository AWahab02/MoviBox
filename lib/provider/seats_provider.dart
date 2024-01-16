import 'package:flutter/material.dart';

import '../user_interface/themes/colors.dart';

class seatsProvider with ChangeNotifier {
  int _totalprice = 0;

  int get totalprice => _totalprice;

  void updateTotalPrice(int row, int col, List<List<Color>> seatColors) {
    int selectedSeatsCount = 0;

    for (int i = 0; i < seatColors.length; i++) {
      for (int j = 0; j < seatColors[0].length; j++) {
        if (seatColors[i][j] == kSelected) {
          selectedSeatsCount++;
        }
      }
    }

    // Update the seat color
    seatColors[row][col] = kSelected;

    // Update total price based on the selected seats count
    _totalprice += 50;

    // Notify listeners
    notifyListeners();
  }
}
