import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

import '../app_colors.dart';

class CustomSnackbar {
  static void show({
    required String message,
    required Color backgroundColor,
    required IconData icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    Get.snackbar(
      '',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor,
      colorText: AppColors.surface,
      duration: duration,
      margin: EdgeInsets.all(16),
      borderRadius: 12,
      icon: Icon(
        icon,
        color: AppColors.surface,
      ),
      shouldIconPulse: false,
      barBlur: 20,
    );
  }

  static void showSuccess(String message) {
    show(
      message: message,
      backgroundColor: AppColors.success,
      icon: Icons.check_circle,
    );
  }

  static void showError(String message) {
    show(
      message: message,
      backgroundColor: AppColors.error,
      icon: Icons.error,
    );
  }

  static void showInfo(String message) {
    show(
      message: message,
      backgroundColor: AppColors.primary,
      icon: Icons.info,
    );
  }

  static void showWarning(String message) {
    show(
      message: message,
      backgroundColor: AppColors.warning,
      icon: Icons.warning,
    );
  }
}
