import 'package:get/get.dart';

class ToggleController extends GetxController {
  RxBool isPlayed = false.obs;

  void toggle() {
    isPlayed.value = !isPlayed.value;
  }
}
