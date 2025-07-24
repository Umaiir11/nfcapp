import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'main.dart';
import 'nfc_controller.dart';
import 'nfc_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NfcService>(() => NfcService());
    Get.lazyPut<NfcController>(() => NfcController());
  }
}
