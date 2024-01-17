import 'package:flutter/material.dart';

import '../user_interface/themes/colors.dart';

class seatsProvider with ChangeNotifier {
  int _totalprice = 0;

  int get totalprice => _totalprice;

  void settotalprice(int x) {
    _totalprice = x;
    notifyListeners();
  }

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
    if (seatColors[row][col] == kSelected) {
      seatColors[row][col] = kGetTickets;
      _totalprice -= 50;
    } else if (seatColors[row][col] == kGetTickets) {
      seatColors[row][col] = kSelected;
      _totalprice += 50;
    } else if (seatColors[row][col] == kVIP) {
      seatColors[row][col] = kSelected;
      _totalprice += 150;
    }

    // Notify listeners
    notifyListeners();
  }
}
