import 'dart:io';

import 'package:admost_flutter_plugin/admost.dart';
import 'package:advertising_id/advertising_id.dart';
import 'package:analysist/ui/home/bottom_tabbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:analysist/models/Account.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:analysist/services/remote_config.dart';
import 'core/initial_bindings.dart';
import 'core/routes.dart';
import 'core/theme_manager.dart';
import 'models/Followers.dart';
import 'models/Followings.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await RemoteConfigService().initialize();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Hive.initFlutter();

  Hive.registerAdapter(FollowingUsersAdapter());
  Hive.registerAdapter(FollowerUsersAdapter());
  Hive.registerAdapter(AccountAdapter());
  await Hive.openBox<FollowerUsers>("followers");
  await Hive.openBox<Account>("accounts");
  await Hive.openBox<FollowingUsers>("followings");
  await EasyLocalization.ensureInitialized();
  Admost.initialize(
      appId: RemoteConfigService().admostAppId,
      userConsent: "1",
      subjectToGDPR: "1",
      subjectToCCPA: "0");
  print(await AdvertisingId.id(true));
  runApp(EasyLocalization(
      supportedLocales: [
        Locale('de'),
        Locale('en'),
        Locale('tr'),
        Locale('ar'),
        Locale('it'),
        Locale('es'),
      ],
      path:
          'assets/localizations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      title: 'Analysist',
      initialRoute: AppRoutes.initialRoute,
      getPages: AppRoutes.pages,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        EasyLocalization.of(context)!.delegate,
      ],
      builder: (BuildContext context, Widget? child) {
        return Column(
          mainAxisSize: MainAxisSize.max,
          children: [Expanded(child: child!), BottomTabBar()],
        );
      },
      supportedLocales: EasyLocalization.of(context)!.supportedLocales,
      locale: EasyLocalization.of(context)!.locale,
      initialBinding: InitialBindings(),
    );
  }
}
