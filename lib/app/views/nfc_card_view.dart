import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/custom_snackbar.dart';
import '../configs/app_colors.dart';

class NfcCardView extends StatelessWidget {
  final String title;
  final String data;
  final VoidCallback? onClear;

  const NfcCardView({
    Key? key,
    required this.title,
    required this.data,
    this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              if (onClear != null)
                IconButton(
                  onPressed: onClear,
                  icon: Icon(
                    Icons.clear,
                    color: AppColors.textSecondary,
                    size: 20.w,
                  ),
                ),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: AppColors.divider.withOpacity(0.5),
                width: 1.w,
              ),
            ),
            child: Text(
              data,
              style: TextStyle(
                fontSize: 13.sp,
                fontFamily: 'RobotoMono',
                color: AppColors.textPrimary,
                height: 1.5,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: data));
                    CustomSnackbar.showSuccess('Copied to clipboard');
                  },
                  icon: Icon(Icons.copy, size: 16.w, color: AppColors.surface),
                  label: Text(
                    'Copy',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.surface,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    elevation: 0,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}