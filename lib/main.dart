import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AdManagerBannerAd? _adManagerBannerAd;
  bool _adManagerBannerAdIsLoaded = false;

  void _incrementCounter() {
    launch('https://twitter.com/intent/tweet?text=xyz');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _adManagerBannerAd = AdManagerBannerAd(
      adUnitId: '/6499/example/banner',
      request: const AdManagerAdRequest(nonPersonalizedAds: true),
      sizes: <AdSize>[AdSize.largeBanner],
      listener: AdManagerBannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$AdManagerBannerAd loaded.');
          setState(() {
            _adManagerBannerAdIsLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$AdManagerBannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$AdManagerBannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$AdManagerBannerAd onAdClosed.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    super.dispose();
    _adManagerBannerAd?.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.separated(
            itemCount: 20,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 40,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              final AdManagerBannerAd? adManagerBannerAd = _adManagerBannerAd;
              if (index == 1) {
                return MaterialButton(
                  onPressed: _incrementCounter,
                  child: const Text('Twitter'),
                );
              }
              if (index % 5 == 0 &&
                  _adManagerBannerAdIsLoaded &&
                  adManagerBannerAd != null) {
                return SizedBox(
                  height: adManagerBannerAd.sizes[0].height.toDouble(),
                  width: adManagerBannerAd.sizes[0].width.toDouble(),
                  child: AdWidget(ad: _adManagerBannerAd!),
                );
              }

              return const Text(
                "xyz",
                style: TextStyle(fontSize: 24),
              );
            },
          ),
        ),
      );
}
