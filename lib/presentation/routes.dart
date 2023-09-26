import 'package:flutter/material.dart';
import 'package:trello_tasks_sync/presentation/pages/home_page.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Page not Found'),
            ),
          ),
        );
    }
  }
}
