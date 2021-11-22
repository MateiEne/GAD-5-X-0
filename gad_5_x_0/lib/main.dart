import 'package:flutter/material.dart';
import 'package:gad_5_x_0/pages/home.dart';

void main() {
  runApp(const XOGame());
}

class XOGame extends StatelessWidget {
  const XOGame({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) {
          return const HomePage();
        },
      },
    );
  }
}
