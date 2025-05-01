import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calculator/models/design.dart';
import 'package:calculator/models/design_part.dart';
import 'package:image_picker/image_picker.dart';

class DesignController extends GetxController {
  // Design Model with Observable
  final Rx<Design> design = Design(
    cPallu: DesignPart(type: DesignPartType.cPallu),
    pallu: DesignPart(type: DesignPartType.pallu),
    stk: DesignPart(type: DesignPartType.stk),
    blz: DesignPart(type: DesignPartType.blz),
    stitchRate: '0.4',
    addOnPrice: '',
  ).obs;

  // Controllers for stitchRate and addOnPrice
  final stitchRateController = TextEditingController(text: '0.4');
  final addOnPriceController = TextEditingController();

  // Accessors
  DesignPart get cPallu => design.value.cPallu;
  DesignPart get pallu => design.value.pallu;
  DesignPart get stk => design.value.stk;
  DesignPart get blz => design.value.blz;

  double get stitchRate => double.tryParse(stitchRateController.text) ?? 0;
  double get addOnPrice => double.tryParse(addOnPriceController.text) ?? 0;

  // Totals
  final cPalluTotal = 0.0.obs;
  final palluTotal = 0.0.obs;
  final stkTotal = 0.0.obs;
  final blzTotal = 0.0.obs;
  final grandTotal = 0.0.obs;

  // On Init
  @override
  void onInit() {
    super.onInit();
    // Add listeners to update totals when values change
    _bindControllers();
    updateTotal();
  }

  void _bindControllers() {
    // DesignPart listeners
    for (var part in [cPallu, pallu, stk, blz]) {
      part.headController.addListener(updateTotal);
      part.stitchesController.addListener(updateTotal);
    }

    // Global values
    stitchRateController.addListener(updateTotal);
    addOnPriceController.addListener(updateTotal);
  }

  // Update all totals
  void updateTotal() {
    cPalluTotal.value = cPallu.total(stitchRate);
    palluTotal.value = pallu.total(stitchRate);
    stkTotal.value = stk.total(stitchRate);
    blzTotal.value = blz.total(stitchRate);
    grandTotal.value = finalTotal();
  }

// Final total
  double finalTotal() =>
      cPalluTotal.value +
      palluTotal.value +
      stkTotal.value +
      blzTotal.value +
      addOnPrice;

  // Individual getters
  double getC_PalluTotal() => cPalluTotal.value;
  double getPalluTotal() => palluTotal.value;
  double getStkTotal() => stkTotal.value;
  double getBlzTotal() => blzTotal.value;

  void clearAllFields() {
    // Clear part controllers
    for (var part in [cPallu, pallu, stk, blz]) {
      part.headController.clear();
      part.stitchesController.clear();
    }

    // Clear global controllers
    stitchRateController.clear();
    addOnPriceController.clear();

    // Reset totals
    updateTotal();
  }

  RxList<String> designImages = <String>[].obs;

  final ImagePicker _picker = ImagePicker();

  // Method to pick image
  Future<void> pickImage() async {
    // Show image picker dialog
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null && designImages.length < 5) {
      // Add picked image to list
      designImages.add(pickedFile.path);
    }
  }

  // Method to remove image
  void removeImage(int index) {
    designImages.removeAt(index);
  }
}
