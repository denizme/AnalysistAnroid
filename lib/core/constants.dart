import 'package:logger/logger.dart';
import 'package:easy_localization/easy_localization.dart';

var logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);
Map<String, dynamic> headers = {
  "Connection": "close",
  "Accept": "/",
  "Accept-Language": "en-US",
  "Accept-Encoding": "gzip, deflate",
  "X-IG-Capabilities": "3brTvw==",
  "X-IG-Connection-Type": "WIFI",
  "X-IG-Connection-Speed": "3629kbps",
  "X-IG-App-ID": "567067343352427",
  "X-IG-Bandwidth-Speed-KBPS": "-1.000",
  "X-IG-Bandwidth-TotalBytes-B": "0",
  "X-IG-Bandwidth-TotalTime-MS": "0",
  "X-FB-HTTP-Engine": "Liger",
};
String translate(String word) {
  return word.tr();
}

const revenucatAppId = "goog_NNTvOyeVLduHYCheVPrpoGYJztJ";
const oneSignalAppId = "2357179b-9719-4741-b37c-d47a86c60a20";
const supportEmail = "support@reports-followers.click";

String appLink =
    "https://play.google.com/store/apps/details?id=insta.followers.unfollowers.analyzer";

// String bannerAdUnitIdForAndroid = "ca-app-pub-4033964200227996/7702905909";
// String intersitialAdUnitIdForAndroid = "ca-app-pub-4033964200227996/3028614989";
// String appOpenAdUnitIdForAndroid = "ca-app-pub-4033964200227996/9402451641";
// String appOpenAdUnitIdForIos = "ca-app-pub-3940256099942544/1033173712";
// String bannerAdUnitIdForIos = "ca-app-pub-3940256099942544/2934735716";
// String intersitialAdUnitIdForIos = "ca-app-pub-3940256099942544/4411468910";

//test ads

String bannerAdUnitIdForAndroid = "ca-app-pub-3940256099942544/6300978111";
String intersitialAdUnitIdForAndroid = "ca-app-pub-3940256099942544/1033173712";
String appOpenAdUnitIdForAndroid = "ca-app-pub-3940256099942544/3419835294";
String appOpenAdUnitIdForIos = "ca-app-pub-3940256099942544/1033173712";
String bannerAdUnitIdForIos = "ca-app-pub-3940256099942544/2934735716";
String intersitialAdUnitIdForIos = "ca-app-pub-3940256099942544/4411468910";
