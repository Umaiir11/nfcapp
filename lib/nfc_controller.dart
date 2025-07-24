import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nfcapp/widgets/custom_snackbar.dart';
import 'logger.dart';
import 'nfc_service.dart';

class NfcController extends GetxController {
  static const platform = MethodChannel('com.example.nfcapp/nfc');
  final NfcService _nfcService = NfcService();
  var isLoading = false.obs;
  var cardData = ''.obs;
  var writeData = ''.obs;
  var isNfcSupported = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkNfcSupport();
    _checkNfcIntent();
  }

  Future<void> checkNfcSupport() async {
    try {
      isNfcSupported.value = await _nfcService.isNfcAvailable();
      if (!isNfcSupported.value) {
        CustomSnackbar.showError('NFC is not supported on this device');
      }
    } catch (e) {
      Logger.error('Error checking NFC support: $e');
      isNfcSupported.value = false;
      CustomSnackbar.showError('Error checking NFC support');
    }
  }

  Future<void> _checkNfcIntent() async {
    if (!isNfcSupported.value) return; // Skip if NFC is not supported
    try {
      final intentAction = await platform.invokeMethod('checkNfcIntent');
      if (intentAction != null && intentAction.contains('android.nfc.action')) {
        Logger.info('NFC intent detected: $intentAction');
        await readNfcCard();
      }
    } catch (e) {
      Logger.error('Error checking NFC intent: $e');
    }
  }

  Future<void> readNfcCard() async {
    if (!isNfcSupported.value) {
      CustomSnackbar.showError('NFC is not supported');
      return;
    }
    try {
      isLoading.value = true;
      CustomSnackbar.showInfo('Hold your NFC card near the device...');
      final result = await _nfcService.readNfcCard();
      if (result != null && result.isNotEmpty) {
        cardData.value = result;
        Logger.info('Card Read Successfully: $result');
        CustomSnackbar.showSuccess('Card read successfully!');
      } else {
        CustomSnackbar.showError('No data found on card');
      }
    } catch (e) {
      Logger.error('NFC Read Error: $e');
      CustomSnackbar.showError('Failed to read card: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> writeToNfcCard() async {
    if (!isNfcSupported.value) {
      CustomSnackbar.showError('NFC is not supported');
      return;
    }
    if (writeData.value.isEmpty) {
      CustomSnackbar.showError('Please enter data to write');
      return;
    }
    try {
      isLoading.value = true;
      CustomSnackbar.showInfo('Hold your NFC card near the device to write...');
      final success = await _nfcService.writeToNfcCard(writeData.value);
      if (success) {
        Logger.info('Card Write Successfully: ${writeData.value}');
        CustomSnackbar.showSuccess('Data written successfully!');
        writeData.value = '';
      } else {
        CustomSnackbar.showError('Failed to write data to card');
      }
    } catch (e) {
      Logger.error('NFC Write Error: $e');
      CustomSnackbar.showError('Failed to write to card: ${e.toString()}');
    } finally {
      isLoading.value = false;
    }
  }

  void updateWriteData(String data) {
    writeData.value = data;
  }

  void clearCardData() {
    cardData.value = '';
  }
}