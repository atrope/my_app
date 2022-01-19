import 'package:flutter/material.dart';
import 'package:my_app/ad_banner.dart';
import 'package:my_app/page_two.dart';

void main() {
  runApp(MaterialApp(
    home: const MyApp(),
    color: Colors.white,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Route'),
      ),
      body: Column(
        children: [
          const AdBanner(),
          ElevatedButton.icon(
            icon: const Icon(Icons.web),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PageTwo()),
              );
            },
            label: const Text('Click Me'),
          ),
        ],
      ),
    );
  }
}
