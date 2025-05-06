import 'package:calculator/helpers/defaults.dart';
import 'package:calculator/models/design_part.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignFormController extends GetxController {
  // Text Controllers for input fields
  final designNumberController = TextEditingController();
  final designNameController = TextEditingController();
  final stitchRateController = TextEditingController(text: "0.40");
  final addOnPriceController = TextEditingController();

  // Part fields (example: manually typed or passed from another input)
  final cPalluHead = TextEditingController(text: getDefault(DesignPartType.cPallu).toString());
  final cPalluStitches = TextEditingController();
  final palluHead = TextEditingController(text: getDefault(DesignPartType.pallu).toString());
  final palluStitches = TextEditingController();
  final stkHead = TextEditingController(text: getDefault(DesignPartType.stk).toString());
  final stkStitches = TextEditingController();
  final blzHead = TextEditingController(text: getDefault(DesignPartType.blz).toString());
  final blzStitches = TextEditingController();

  // Selected images
  final RxList<String> selectedImages = <String>[].obs;

  // Form validation method
  bool validateForm() {
    return designNumberController.text.isNotEmpty &&
        designNameController.text.isNotEmpty &&
        stitchRateController.text.isNotEmpty;
  }

  // Clear all input fields
  void clearForm() {
    designNumberController.clear();
    designNameController.clear();
    stitchRateController.clear();
    addOnPriceController.clear();

    cPalluHead.clear();
    cPalluStitches.clear();
    palluHead.clear();
    palluStitches.clear();
    stkHead.clear();
    stkStitches.clear();
    blzHead.clear();
    blzStitches.clear();

    selectedImages.clear();
  }

  @override
  void onClose() {
    // Dispose all controllers
    designNumberController.dispose();
    designNameController.dispose();
    stitchRateController.dispose();
    addOnPriceController.dispose();
    cPalluHead.dispose();
    cPalluStitches.dispose();
    palluHead.dispose();
    palluStitches.dispose();
    stkHead.dispose();
    stkStitches.dispose();
    blzHead.dispose();
    blzStitches.dispose();
    super.onClose();
  }
}
