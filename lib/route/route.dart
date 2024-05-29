
import 'package:flutter/material.dart';
import 'package:starsport/Presentation/Screens/Home/Home.dart';




class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => Home_Screen(

          ),
        );

      default:
        return MaterialPageRoute(
            builder: (_) => Center(
              child: Text("Erreur"),
            )
        );
    }
  }
}