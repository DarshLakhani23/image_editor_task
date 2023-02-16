import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_editor/utils/app_colors.dart';

class AppSnackBar {
  static void showErrorSnackBar({required String message, required String title, Color? color}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      borderRadius: 8,
      backgroundColor: color ?? Colors.black45,
      animationDuration: const Duration(milliseconds: 500),
      barBlur: 10,
      colorText: AppColors.white,
      isDismissible: true,
      duration: const Duration(seconds: 2),
    );
  }
}
