import 'package:flutter/material.dart';
import 'package:my_app/ad_banner.dart';
import 'package:url_launcher/url_launcher.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({Key? key}) : super(key: key);

  void _onPressed() async =>
      await launch('https://twitter.com/intent/tweet?text=xyz');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Column(
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.web),
            onPressed: _onPressed,
            label: const Text('Click Me'),
          ),
          const AdBanner(),
        ],
      ),
    );
  }
}
