import 'package:firebase_remote_config/firebase_remote_config.dart';

const String _bannerActive = "bannerActive";
const String _activeAppOpen = "activeAppOpen";
const String _intersitialCount = "intersitialCount";
const String _messagesActive = "messagesActive";
const String _intersitialId = "intersitialId";
const String _bannerId = "bannerId";
const String _notificationInterval = "notificationInterval";
const String _admostAppId = "admostAppId";
const String _appOpenId = "appOpenId";
const String _userAgent = "userAgent";
const String _privacyPolicy = "privacyPolicy";

class RemoteConfigService {
  final defaults = <String, dynamic>{
    _bannerActive: true,
    _activeAppOpen: true,
    _messagesActive: false,
    _intersitialCount: 3,
    _notificationInterval: 30,
    _privacyPolicy: 30,
  };

  bool get bannerActive => remoteConfig.getBool(_bannerActive);
  String get intersitialId => remoteConfig.getString(_intersitialId);
  String get userAgent => remoteConfig.getString(_userAgent);
  String get privacyPolicy => remoteConfig.getString(_privacyPolicy);
  String get appOpen => remoteConfig.getString(_appOpenId);
  String get bannerId => remoteConfig.getString(_bannerId);
  String get admostAppId => remoteConfig.getString(_admostAppId);
  int get notificationInterval => remoteConfig.getInt(_notificationInterval);
  bool get messagesActive => remoteConfig.getBool(_messagesActive);
  int get intersitialCount => remoteConfig.getInt(_intersitialCount);
  bool get activeAppOpen => remoteConfig.getBool(_activeAppOpen);
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  Future initialize() async {
    try {
      final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 10),
        minimumFetchInterval: const Duration(seconds: 30),
      ));
      await remoteConfig.setDefaults(defaults);
      await _fetchAndActivate();
    } catch (e) {
      print(
          'Unable to fetch remote config. Cached or default values will be used');
    }
  }

  Future _fetchAndActivate() async {
    await remoteConfig.fetch();
    await remoteConfig.activate();
  }
}
