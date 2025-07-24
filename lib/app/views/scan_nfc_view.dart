import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../configs/app_colors.dart';
import '../controller/nfc_controller.dart';
import 'nfc_card_view.dart';

class ScanNfcScreen extends StatelessWidget {
  final NfcController _controller = Get.find<NfcController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Scan Staff NFC',
          style: TextStyle(
            color: AppColors.surface,
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.surface, size: 24.w),
          onPressed: () => Get.back(),
        ),
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
            children: [
              SizedBox(height: 32.h),
              Obx(() => AnimatedContainer(
                duration: Duration(milliseconds: 600),
                width: 180.w,
                height: 180.w,
                decoration: BoxDecoration(
                  color: _controller.isLoading.value
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _controller.isLoading.value
                        ? AppColors.primary
                        : AppColors.divider.withOpacity(0.5),
                    width: 1.5.w,
                  ),
                  boxShadow: _controller.isLoading.value
                      ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 16.r,
                      spreadRadius: 4.r,
                    ),
                  ]
                      : [],
                ),
                child: Center(
                  child: _controller.isLoading.value
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.nfc,
                        size: 48.w,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                          strokeWidth: 2.w,
                        ),
                      ),
                    ],
                  )
                      : Icon(
                    Icons.nfc,
                    size: 64.w,
                    color: AppColors.textSecondary,
                  ),
                ),
              )),
              SizedBox(height: 24.h),
              Text(
                'Scan NFC Card',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Hold the staff NFC card near your device',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
              SizedBox(height: 32.h),
              Obx(() => PrimaryButton(
                text: _controller.isLoading.value ? 'Scanning...' : 'Start Scan',
                onPressed: _controller.isLoading.value ? null : _controller.readNfcCard,
                color: AppColors.primary,
                icon: Icons.radar,
              )),
              SizedBox(height: 24.h),
              Obx(() => _controller.cardData.value.isNotEmpty
                  ? NfcCardView(
                title: 'Staff Card Data',
                data: _controller.cardData.value,
                onClear: _controller.clearCardData,
              )
                  : SizedBox.shrink()),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}