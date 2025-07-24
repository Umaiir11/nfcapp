import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../configs/app_colors.dart';
import '../controller/nfc_controller.dart';
import 'scan_nfc_view.dart';
import 'write_nfc.dart';

class HomeScreen extends StatelessWidget {
  final NfcController controller = Get.find<NfcController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Staff NFC Sign-In',
          style: TextStyle(
            color: AppColors.surface,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.8)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 12.r,
                      offset: Offset(0, 4.h),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.nfc,
                      size: 64.w,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Staff Sign-In/Out',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Effortlessly manage staff attendance with NFC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              PrimaryButton(
                text: 'Sign In',
                onPressed: () => Get.to(() => ScanNfcScreen()),
                color: AppColors.primary,
                icon: Icons.login,
              ),
              SizedBox(height: 16.h),
              PrimaryButton(
                text: 'Sign Out',
                onPressed: () => Get.to(() => WriteNfcScreen()),
                color: AppColors.primary.withOpacity(0.8),
                icon: Icons.logout,
              ),
              Spacer(),
              Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: controller.isNfcSupported.value
                      ? AppColors.success.withOpacity(0.15)
                      : AppColors.error.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      controller.isNfcSupported.value
                          ? Icons.check_circle_outline
                          : Icons.error_outline,
                      color: controller.isNfcSupported.value
                          ? AppColors.success
                          : AppColors.error,
                      size: 16.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      controller.isNfcSupported.value
                          ? 'NFC Enabled'
                          : 'NFC Unavailable',
                      style: TextStyle(
                        color: controller.isNfcSupported.value
                            ? AppColors.success
                            : AppColors.error,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              )),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}