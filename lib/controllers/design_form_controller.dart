import 'package:calculator/helpers/defaults.dart';
import 'package:calculator/models/design.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignFormController extends GetxController {
  // Main fields
  final designNumberController = TextEditingController();
  final designNameController = TextEditingController();
  final stitchRateController = TextEditingController();
  final addOnPriceController = TextEditingController();

  // Part fields
  final cPalluHeadController = TextEditingController();
  final cPalluStitchesController = TextEditingController();
  final palluHeadController = TextEditingController();
  final palluStitchesController = TextEditingController();
  final stkHeadController = TextEditingController();
  final stkStitchesController = TextEditingController();
  final blzHeadController = TextEditingController();
  final blzStitchesController = TextEditingController();

  // Images
  final RxList<String> selectedImages = <String>[].obs;
  // Flag to prevent triggering listeners during initialization
  bool isInitializing = false;

  @override
  void onInit() {
    super.onInit();
    fillForm(getDefaultDesign());
  }

  // Fill form with a given design object
  void fillForm(Design design) {
    isInitializing = true;

    designNumberController.text = design.designNumber;
    designNameController.text = design.designName;
    stitchRateController.text =
        sanitizeDoubleInput(design.stitchRate, flexible: false);
    addOnPriceController.text = sanitizeDoubleInput(design.addOnPrice);

    cPalluHeadController.text = sanitizeDoubleInput(design.cPallu.head);
    cPalluStitchesController.text = sanitizeDoubleInput(design.cPallu.stitches);
    palluHeadController.text = sanitizeDoubleInput(design.pallu.head);
    palluStitchesController.text = sanitizeDoubleInput(design.pallu.stitches);
    stkHeadController.text = sanitizeDoubleInput(design.stk.head);
    stkStitchesController.text = sanitizeDoubleInput(design.stk.stitches);
    blzHeadController.text = sanitizeDoubleInput(design.blz.head);
    blzStitchesController.text = sanitizeDoubleInput(design.blz.stitches);

    selectedImages.clear();

    isInitializing = false;
  }

  // Basic validation
  bool validateForm() {
    return designNumberController.text.isNotEmpty &&
        designNameController.text.isNotEmpty &&
        stitchRateController.text.isNotEmpty;
  }

  bool isFormValid() {
    return designNumberController.text.isNotEmpty &&
        designNameController.text.isNotEmpty;
  }

  // Clear form
  void resetForm() {
    isInitializing = true;
    designNumberController.clear();
    designNameController.clear();
    stitchRateController.text =
        sanitizeDoubleInput(kStitchRate.toString(), flexible: false);
    addOnPriceController.clear();

    cPalluHeadController.text = sanitizeDoubleInput(kcPalluHead.toString());
    cPalluStitchesController.clear();
    palluHeadController.text = sanitizeDoubleInput(kpalluHead.toString());
    palluStitchesController.clear();
    stkHeadController.text = sanitizeDoubleInput(kstkHead.toString());
    stkStitchesController.clear();
    isInitializing = false;
    blzHeadController.text = sanitizeDoubleInput(kblzHead.toString());
    blzStitchesController.clear();

    selectedImages.clear();
  }

  // Sanitize user input
  String sanitizeDoubleInput(dynamic value, {bool flexible = true}) {
    if (value == 0 || value == 0.0) return '';
    if (value is double) value = value.toString();

    if (flexible) {
      value = value.replaceAll(RegExp(r'[^0-9.]'), '');
      int firstDotIndex = value.indexOf('.');

      if (firstDotIndex != -1) {
        value = value.substring(0, firstDotIndex + 1) +
            value.substring(firstDotIndex + 1).replaceAll('.', '');
      }

      if (value[value.toString().length - 1] == '.') return value;

      double parsed = double.tryParse(value) ?? 0.0;
      String result = parsed.toStringAsFixed(2);

      if (result.endsWith('.00')) {
        return result.substring(0, result.length - 3); // Remove ".00"
      }

      if (result.endsWith('0')) {
        return result.substring(
            0, result.length - 1); // Remove single trailing "0"
      }

      return result; // Return the result if no unnecessary trailing zeros
    }

    double parsed = double.tryParse(value) ?? 0.0;
    return parsed.toStringAsFixed(2);
  }

  @override
  void onClose() {
    designNumberController.dispose();
    designNameController.dispose();
    stitchRateController.dispose();
    addOnPriceController.dispose();

    cPalluHeadController.dispose();
    cPalluStitchesController.dispose();
    palluHeadController.dispose();
    palluStitchesController.dispose();
    stkHeadController.dispose();
    stkStitchesController.dispose();
    blzHeadController.dispose();
    blzStitchesController.dispose();

    super.onClose();
  }
}
