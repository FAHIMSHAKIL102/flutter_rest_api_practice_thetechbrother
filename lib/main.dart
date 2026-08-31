import 'package:flutter/material.dart';
import 'package:flutter_rest_api_practice_thetechbrother/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return HomePage();
  }
}
