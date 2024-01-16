import 'package:flutter/material.dart';
import 'package:movies_tickets_task/user_interface/screens/media_library.dart';
import 'package:movies_tickets_task/user_interface/screens/more.dart';
import 'package:movies_tickets_task/user_interface/screens/tickets_pages/tickets_page.dart';
import 'package:movies_tickets_task/user_interface/screens/welcome_page.dart';
import 'package:movies_tickets_task/user_interface/screens/watch_screen.dart';

class Routes {
  static const String welcomePage = '/';
  static const String watchScreen = '/watch';
  static const String ticketsScreen = '/tickets';
  static const String moreScreen = '/more';
  static const String mediaLibraryscreen = '/mediaLibrary';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.welcomePage:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.watchScreen:
        return MaterialPageRoute(builder: (_) => const WatchScreen());
      case Routes.ticketsScreen:
        return MaterialPageRoute(
            builder: (_) => const TicketsScreen(
                  title: 'me',
                  release: "2020",
                ));
      case Routes.moreScreen:
        return MaterialPageRoute(builder: (_) => const MorePage());
      case Routes.mediaLibraryscreen:
        return MaterialPageRoute(builder: (_) => const MediaLibraryPage());
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
