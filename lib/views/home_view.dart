import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nfcapp/views/scan_nfc_view.dart';
import 'package:nfcapp/views/write_nfc.dart';

import '../app_colors.dart';
import '../main.dart';
import '../nfc_controller.dart';
import '../widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  final NfcController controller = Get.find<NfcController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'NFC Card Tools',
          style: TextStyle(
            color: AppColors.surface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),

              // Header Section
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.nfc,
                      size: 80,
                      color: AppColors.primary,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'NFC Card Tools',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Scan or write to your NFC card securely',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 50),

              // Action Buttons
              PrimaryButton(
                text: '📥 Scan Card (Read)',
                onPressed: () => Get.to(() => ScanNfcScreen()),
                color: AppColors.primary,
                icon: Icons.nfc,
              ),

              SizedBox(height: 20),

              PrimaryButton(
                text: '✍️ Write to Card',
                onPressed: () => Get.to(() => WriteNfcScreen()),
                color: AppColors.secondary,
                icon: Icons.edit,
              ),

              Spacer(),

              // NFC Status
              Obx(() => Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: controller.isNfcSupported.value
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.error.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      controller.isNfcSupported.value
                          ? Icons.check_circle
                          : Icons.error,
                      color: controller.isNfcSupported.value
                          ? AppColors.success
                          : AppColors.error,
                      size: 16,
                    ),
                    SizedBox(width: 8),
                    Text(
                      controller.isNfcSupported.value
                          ? 'NFC Ready'
                          : 'NFC Not Supported',
                      style: TextStyle(
                        color: controller.isNfcSupported.value
                            ? AppColors.success
                            : AppColors.error,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
