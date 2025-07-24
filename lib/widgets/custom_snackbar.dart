import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/configs/app_colors.dart';

class CustomSnackbar {
  static void _show({
    required String title,
    required String message,
    required Color backgroundColor,
    Duration duration = const Duration(seconds: 2),
  }) {
    Get.closeCurrentSnackbar();

    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: Colors.white70,
        ),
      ),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      borderRadius: 6,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      duration: duration,
      animationDuration: const Duration(milliseconds: 180),
      isDismissible: true,
      shouldIconPulse: false,
      barBlur: 0,
      overlayBlur: 0,
      icon: null,
      forwardAnimationCurve: Curves.easeOut,
    );
  }

  static void showSuccess(String message) {
    _show(
      title: 'Success',
      message: message,
      backgroundColor: AppColors.success,
    );
  }

  static void showError(String message) {
    _show(
      title: 'Error',
      message: message,
      backgroundColor: AppColors.error,
    );
  }

  static void showInfo(String message) {
    _show(
      title: 'Info',
      message: message,
      backgroundColor: AppColors.primary,
    );
  }

  static void showWarning(String message) {
    _show(
      title: 'Warning',
      message: message,
      backgroundColor: AppColors.warning,
    );
  }
}
