import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClickEffectController extends GetxController {
  RxList<bool> clickStates;
  RxList<GlobalKey> posKeys;

  ClickEffectController(int length)
      : clickStates = List.generate(length, (_) => false).obs,
        posKeys = List.generate(length, (_) => GlobalKey()).obs;

  // Enlarge button effect with delayed revert
  void buttonEnlarge(int index) {
    clickStates[index] = true; // Start enlarging
    Future.delayed(const Duration(milliseconds: 200), () {
      if (clickStates.length > index && clickStates[index] == true) {
        clickStates[index] = false; // Revert scaling
      }
    });
  }

  void updateLength(int length) {
    clickStates = List.generate(length, (_) => false).obs;
    posKeys = List.generate(length, (_) => GlobalKey()).obs;
  }

  // Shrink button effect
  void buttonShrink(int index) {
    if (clickStates.length > index) {
      clickStates[index] = false; // Explicitly reset to false
    }
  }
}
