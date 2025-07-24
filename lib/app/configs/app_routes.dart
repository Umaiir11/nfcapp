import 'package:flutter/animation.dart';
import 'package:get/get.dart';

import '../controller/nfc_controller.dart';
import '../views/home_view.dart';
import '../views/scan_nfc_view.dart';
import '../views/splash_view.dart';
import '../views/write_nfc.dart';

abstract class AppRoutes {
  AppRoutes._();

  static const splashView = '/splashView';
  static const homeView = '/homeView';
  static const nfcCardView = '/nfcCardView';
  static const scanCardView = '/scanCardView';
  static const writeCardView = '/writeCardView';
}

abstract class AppPages {
  AppPages._();

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splashView,
      page: () => SplashScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NfcController>(() => NfcController());
      }),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    ),
    GetPage(
      name: AppRoutes.homeView,
      page: () => HomeScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NfcController>(() => NfcController());
      }),
      transition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 350),
      curve: Curves.easeOutQuad,
    ),
    GetPage(
      name: AppRoutes.scanCardView,
      page: () => ScanNfcScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NfcController>(() => NfcController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutQuart,
    ),
    GetPage(
      name: AppRoutes.writeCardView,
      page: () => WriteNfcScreen(),
      binding: BindingsBuilder(() {
        Get.lazyPut<NfcController>(() => NfcController());
      }),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
      curve: Curves.easeInOutQuart,
    ),
  ];
}