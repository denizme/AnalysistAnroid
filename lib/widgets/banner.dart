import 'dart:io';
import 'package:admost_flutter_plugin/admost_banner.dart';
import 'package:admost_flutter_plugin/admost_banner_size.dart';
import 'package:admost_flutter_plugin/admost_event_handler.dart';
import 'package:admost_flutter_plugin/admost_interstitial.dart';
import 'package:analysist/services/remote_config.dart';
import 'package:flutter/material.dart';

class BannerAdWidget extends StatefulWidget {
  BannerAdWidget(this.size);

  final AdmostBannerSize size;

  @override
  State<StatefulWidget> createState() => BannerAdState();
}

class BannerAdState extends State<BannerAdWidget> {
  bool bannerAdFailedToLoad = false;
  double marginHeigth = 10;

  @override
  Widget build(BuildContext context) {
    if (bannerAdFailedToLoad) {
      return Container(
        height: 0,
      );
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: AdmostBanner(
          adUnitId: RemoteConfigService().bannerId,
          adSize: widget.size,
          listener: (AdmostAdEvent event, Map<String, dynamic> args) {
            if (event == AdmostAdEvent.loaded) {
              print("ADMOST Ad Loaded");
            }
            if (event == AdmostAdEvent.clicked) {
              print("ADMOST Ad clicked");
            }
            if (event == AdmostAdEvent.failedToLoad) {
              print("Error code: ${args['errorCode']}");
              setState(() {
                bannerAdFailedToLoad = true;
              });
            }
          },
          tag: '',
        ),
      );
    }
  }
}
