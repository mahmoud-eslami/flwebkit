import 'package:flutter/material.dart';

import 'components/base_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flwebkit',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const BasePage(),
    );
  }
}
