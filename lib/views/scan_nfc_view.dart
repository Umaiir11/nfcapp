import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../app_colors.dart';
import '../main.dart';
import '../nfc_controller.dart';
import '../widgets/custom_button.dart';
import 'nfc_card_view.dart';

class ScanNfcScreen extends StatelessWidget {
  final NfcController controller = Get.find<NfcController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Scan NFC Card',
          style: TextStyle(
            color: AppColors.surface,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.surface),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            children: [
              SizedBox(height: 40),

              // NFC Animation
              Obx(() => AnimatedContainer(
                duration: Duration(milliseconds: 500),
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: controller.isLoading.value
                      ? AppColors.primary.withOpacity(0.1)
                      : AppColors.surface,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: controller.isLoading.value
                        ? AppColors.primary
                        : AppColors.divider,
                    width: 2,
                  ),
                  boxShadow: controller.isLoading.value ? [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ] : [],
                ),
                child: Center(
                  child: controller.isLoading.value
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.nfc,
                        size: 60,
                        color: AppColors.primary,
                      ),
                      SizedBox(height: 10),
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primary,
                        ),
                      ),
                    ],
                  )
                      : Icon(
                    Icons.nfc,
                    size: 80,
                    color: AppColors.textSecondary,
                  ),
                ),
              )),

              SizedBox(height: 30),

              Text(
                'Hold card near device',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 10),

              Text(
                'Position your NFC card close to the back of your phone',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),

              SizedBox(height: 40),

              // Scan Button
              Obx(() => PrimaryButton(
                text: controller.isLoading.value ? 'Scanning...' : 'Start Scan',
                onPressed: controller.isLoading.value ? null : controller.readNfcCard,
                color: AppColors.primary,
                icon: Icons.radar,
              )),

              SizedBox(height: 30),

              // Card Data Display
              Obx(() => controller.cardData.value.isNotEmpty
                  ? NfcCardView(
                title: 'Card Information',
                data: controller.cardData.value,
                onClear: controller.clearCardData,
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
