import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdBanner extends StatefulWidget {
  const AdBanner({
    Key? key,
  }) : super(key: key);
  @override
  _AdBannerState createState() => _AdBannerState();
}

class _AdBannerState extends State<AdBanner> {
  bool _hasFailed = false;
  AdManagerBannerAd? _banner;
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _banner?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _loadBanner();
    });
  }

  Future<void> _loadBanner() async {
    await AdManagerBannerAd(
      adUnitId: '/6499/example/banner',
      request: const AdManagerAdRequest(nonPersonalizedAds: true),
      sizes: <AdSize>[AdSize.largeBanner],
      listener: AdManagerBannerAdListener(onAdLoaded: (Ad ad) {
        debugPrint('loaded.');
        setState(() {
          _banner = ad as AdManagerBannerAd;
        });
      }, onAdFailedToLoad: (Ad ad, LoadAdError error) {
        debugPrint(' Failed to load with code: ${error.toString()}');
        setState(() {
          _hasFailed = true;
        });
      }),
    ).load();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasFailed || _banner == null) {
      return Container();
    }
    return Container(
      width: AdSize.largeBanner.width.toDouble(),
      height: AdSize.largeBanner.height.toDouble(),
      alignment: Alignment.center,
      child: AdWidget(
        ad: _banner!,
      ),
    );
  }
}
