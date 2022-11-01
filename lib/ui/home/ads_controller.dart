import 'dart:async';
import 'dart:io';
import 'package:admost_flutter_plugin/admost_ad_events.dart';
import 'package:admost_flutter_plugin/admost_interstitial.dart';
import 'package:analysist/core/constants.dart';
import 'package:flutter_fgbg/flutter_fgbg.dart';
import 'package:get/state_manager.dart';
import 'package:analysist/services/remote_config.dart';

class AdsController extends GetxController {
  AdmostInterstitial? interstitialAd;
  AdmostInterstitial? appOpenAd;
  int addCount = 0;
  void createInterstitialAd() async {
    int intersitialCount = RemoteConfigService().intersitialCount;

    if (addCount >= intersitialCount) {
      if (interstitialAd == null) {
        interstitialAd = AdmostInterstitial(
          zoneId: RemoteConfigService().intersitialId,
          listener: (AdmostAdEvent event, Map<String, dynamic> args) {
            if (event == AdmostAdEvent.loaded) {}
            if (event == AdmostAdEvent.dismissed) {
              interstitialAd!.load();
            }
            if (event == AdmostAdEvent.failedToLoad) {
              print("failedToLoad");
              print("Error code: ${args['errorCode']}");
            }
            if (event == AdmostAdEvent.statusChanged) {
              print("statusChanged");
              print("Status: ${args['status']}");
            }
          },
        );
      } else {
        bool? isLoaded = await interstitialAd!.isLoaded;
        if (isLoaded != null && isLoaded) {
          interstitialAd!.show("");
          addCount = 0;
        } else {
          interstitialAd!.load();
        }
      }
    } else {
      logger.i(addCount);
      addCount++;
    }
  }

  @override
  void onInit() {
    addCount = RemoteConfigService().intersitialCount;
    checkAppLifeScale();
    super.onInit();
  }

  StreamSubscription<FGBGType>? subscription;
  checkAppLifeScale() {
    bool appOpen = RemoteConfigService().activeAppOpen;
    if (appOpen) {
      subscription = FGBGEvents.stream.listen((event) async {
        if (event == FGBGType.background) {
          appOpenAd = AdmostInterstitial(
            zoneId: RemoteConfigService().appOpen,
            listener: (AdmostAdEvent event, Map<String, dynamic> args) {
              if (event == AdmostAdEvent.loaded) {}
              if (event == AdmostAdEvent.dismissed) {
                appOpenAd!.load();
              }
              if (event == AdmostAdEvent.failedToLoad) {
                print("failedToLoad");
                print("Error code: ${args['errorCode']}");
              }
              if (event == AdmostAdEvent.statusChanged) {
                print("statusChanged");
                print("Status: ${args['status']}");
              }
            },
          );
        } else {
          bool? isLoaded = await appOpenAd!.isLoaded;
          if (isLoaded != null && isLoaded) {
            appOpenAd!.show("");
            addCount = 0;
          } else {
            appOpenAd!.load();
          }
        }
      });
    }
  }
}
