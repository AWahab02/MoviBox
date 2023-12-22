import 'package:flutter/material.dart';
import 'package:movies_tickets_task/user%20interface/screens/ticketsPages/tickets_page.dart';
import 'package:movies_tickets_task/user%20interface/screens/welcome_page.dart';
import 'package:movies_tickets_task/user%20interface/screens/watch_screen.dart';

class Routes {
  static const String welcomePage = '/';
  static const String watchScreen = '/watch';
  static const String ticketsScreen = '/tickets';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcomePage:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.watchScreen:
        return MaterialPageRoute(builder: (_) => const WatchScreen());
      case Routes.ticketsScreen:
        return MaterialPageRoute(
            builder: (_) => TicketsScreen(
                  title: 'me',
                  release: "2020",
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Page not found'),
        ),
      );
    });
  }
}
