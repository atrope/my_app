import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_app/ad_banner.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PlatformViewsService.synchronizeToNativeViewHierarchy(false);
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
  void _onPressed() async =>
      await launch('https://twitter.com/intent/tweet?text=xyz');

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
            onPressed: _onPressed,
            label: const Text('Click Me'),
          ),
        ],
      ),
    );
  }
}
