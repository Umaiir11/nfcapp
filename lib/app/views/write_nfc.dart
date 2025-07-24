import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widgets/custom_button.dart';
import '../configs/app_colors.dart';
import '../controller/nfc_controller.dart';

class WriteNfcScreen extends StatelessWidget {
  final NfcController _controller = Get.find<NfcController>();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          'Record Sign-Out',

          style: TextStyle(color: AppColors.surface, fontSize: 18.sp, fontWeight: FontWeight.w700, letterSpacing: 0.5),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Text(
                'Sign-Out Data',
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              SizedBox(height: 8.h),
              Text(
                'Enter staff sign-out details for NFC card',
                style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary, height: 1.4),
              ),
              SizedBox(height: 24.h),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12.r, offset: Offset(0, 4.h))],
                ),
                child: TextField(
                  controller: textController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Enter sign-out details...',
                    hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.7), fontSize: 14.sp),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: AppColors.surface,
                    contentPadding: EdgeInsets.all(16.w),
                  ),
                  onChanged: (value) => _controller.updateWriteData(value),
                  style: TextStyle(fontSize: 14.sp, color: AppColors.textPrimary, height: 1.4),
                ),
              ),
              SizedBox(height: 32.h),
              Obx(
                () => PrimaryButton(
                  text: _controller.isLoading.value ? 'Writing...' : 'Write Sign-Out',
                  onPressed: (_controller.isLoading.value || _controller.writeData.value.isEmpty) ? null : _controller.writeToNfcCard,
                  color: AppColors.primaryDark,
                  icon: Icons.edit,
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColors.warning.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.warning.withOpacity(0.3), width: 1.w),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: AppColors.warning, size: 20.w),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Note',
                            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Ensure the NFC card is writable before proceeding.',
                            style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary, height: 1.4),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
