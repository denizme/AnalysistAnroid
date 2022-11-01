import 'package:get/get.dart';
import 'package:analysist/ui/landing/landing.dart';

class AppRoutes {
  static String initialRoute = landing;
  static String welcome = '/welcome';
  static String premium = '/premium';
  static String landing = '/landing';
  static String profile = '/profile';
  static List<GetPage> pages = [
    GetPage(
      name: landing,
      page: () => Landing(),
    ),
    // GetPage(
    //     name: welcome,
    //     page: () => IntroScreen(),
    //     transition: Transition.rightToLeftWithFade),
    // GetPage(
    //     name: login,
    //     page: () => LoginScreen(),
    //     transition: Transition.rightToLeftWithFade),
    // GetPage(
    //     name: signUp,
    //     page: () => SignUpLanding(),
    //     transition: Transition.rightToLeftWithFade),
    // GetPage(
    //     name: profileEdit,
    //     page: () => ProfileEditScreen(),
    //     transition: Transition.rightToLeftWithFade),
    // GetPage(
    //     name: about,
    //     page: () => AboutScreen(),
    //     transition: Transition.rightToLeftWithFade),
    // GetPage(
    //     name: relationship,
    //     page: () => RelationshipScreen(),
    //     transition: Transition.rightToLeftWithFade),
    // GetPage(
    //     name: gender,
    //     page: () => GenderScreen(),
    //     transition: Transition.rightToLeftWithFade),
    // GetPage(
    //     name: job,
    //     page: () => JobScreen(),
    //     transition: Transition.rightToLeftWithFade),
    // GetPage(
    //     name: birthday,
    //     page: () => BirthdayScreen(),
    //     transition: Transition.rightToLeftWithFade),
    // GetPage(
    //     name: premium,
    //     page: () => PremiumScreen(),
    //     transition: Transition.rightToLeftWithFade),
  ];
}
