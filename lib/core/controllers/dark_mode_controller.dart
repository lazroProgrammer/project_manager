import 'package:get/get.dart';

class DarkModeController extends GetxController {
  RxBool darkMode = false.obs;

  void toggle() {
    darkMode.value = !darkMode.value;
  }
}
