import 'package:calculator/controllers/design_form_controller.dart';
import 'package:calculator/controllers/design_mapper.dart';
import 'package:calculator/controllers/storage_controller.dart';
import 'package:calculator/helpers/defaults.dart';
import 'package:calculator/models/design_entity.dart';
import 'package:calculator/models/image_path_entity.dart';
import 'package:calculator/screens/add_design_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/design.dart';
import '../models/design_part.dart';

class DesignController extends GetxController {
  final formController = Get.find<DesignFormController>();
  Rx<Design> design = getDefaultDesign().obs;
  Rx<bool> isEdit = false.obs;

  void setDesign(Design selectedDesign) {
    isEdit.value = selectedDesign.id != null;
    formController.resetForm();
    design.value = selectedDesign.copy(); // Use a deep copy method
    formController.fillForm(design.value);
    formController.selectedImages.value = [
      for (var e in selectedDesign.imagePaths) e.path
    ];
    updateTotal();
  }

  // Totals
  final cPalluTotal = 0.0.obs;
  final palluTotal = 0.0.obs;
  final stkTotal = 0.0.obs;
  final blzTotal = 0.0.obs;
  final grandTotal = 0.0.obs;

  int get id => design.value.id ?? 0;
  double get stitchRate =>
      double.tryParse(formController.stitchRateController.text) ?? 0;
  double get addOnPrice =>
      double.tryParse(formController.addOnPriceController.text) ?? 0;

  String get designNumber => formController.designNumberController.text;
  String get designName => formController.designNameController.text;

  @override
  void onInit() {
    super.onInit();
    _bindControllers();
    updateTotal();
  }

  void _bindControllers() {
    for (var controller in [
      formController.stitchRateController,
      formController.addOnPriceController,
      formController.cPalluHeadController,
      formController.cPalluStitchesController,
      formController.palluHeadController,
      formController.palluStitchesController,
      formController.stkHeadController,
      formController.stkStitchesController,
      formController.blzHeadController,
      formController.blzStitchesController,
    ]) {
      controller.addListener(updateTotal);
    }
  }

  void _updatePartValues(DesignPart part, TextEditingController headCtrl,
      TextEditingController stitchesCtrl) {
    part.head = double.tryParse(headCtrl.text) ?? 0;
    part.stitches = double.tryParse(stitchesCtrl.text) ?? 0;
  }

  void updateTotal() {
    if (Get.find<DesignFormController>().isInitializing) return;
    _updatePartValues(design.value.cPallu, formController.cPalluHeadController,
        formController.cPalluStitchesController);
    _updatePartValues(design.value.pallu, formController.palluHeadController,
        formController.palluStitchesController);
    _updatePartValues(design.value.stk, formController.stkHeadController,
        formController.stkStitchesController);
    _updatePartValues(design.value.blz, formController.blzHeadController,
        formController.blzStitchesController);

    cPalluTotal.value = design.value.cPallu.total(stitchRate);
    palluTotal.value = design.value.pallu.total(stitchRate);
    stkTotal.value = design.value.stk.total(stitchRate);
    blzTotal.value = design.value.blz.total(stitchRate);
    grandTotal.value = finalTotal();
  }

  double finalTotal() =>
      cPalluTotal.value +
      palluTotal.value +
      stkTotal.value +
      blzTotal.value +
      addOnPrice;

  void saveDesign() {
    final designEntity = DesignEntity(
      id: id,
      designNumber: designNumber,
      designName: designName,
      stitchRate: stitchRate.toString(),
      addOnPrice: addOnPrice.toString(),
    );

    designEntity.addParts(
      partToEntity(design.value.cPallu),
      partToEntity(design.value.pallu),
      partToEntity(design.value.stk),
      partToEntity(design.value.blz),
    );

    final storage = Get.find<StorageController>();
    storage.removeImagePathsFromDB(design.value.imagePaths);

    designEntity.addImagePaths([for(String s in formController.selectedImages) ImagePathEntity(path: s)]);
    storage.saveDesign(designEntity);

    clearAllFields();
  }

  void updateDesign() {
    final designEntity = DesignEntity(
      id: design.value.id ?? 0,
      designNumber: designNumber,
      designName: designName,
      stitchRate: stitchRate.toString(),
      addOnPrice: addOnPrice.toString(),
    );

    designEntity.addParts(
      partToEntity(design.value.cPallu),
      partToEntity(design.value.pallu),
      partToEntity(design.value.stk),
      partToEntity(design.value.blz),
    );

    final storage = Get.find<StorageController>();
    storage.removeImagePathsFromDB(design.value.imagePaths);

    designEntity.addImagePaths([for(String s in formController.selectedImages) ImagePathEntity(path: s)]);
    storage.updateDesign(designEntity);
    clearAllFields();
  }

  bool isAtLeastOnePartHasData() {
    for (var pair in [
      [
        formController.cPalluHeadController,
        formController.cPalluStitchesController
      ],
      [
        formController.palluHeadController,
        formController.palluStitchesController
      ],
      [formController.stkHeadController, formController.stkStitchesController],
      [formController.blzHeadController, formController.blzStitchesController],
    ]) {
      if (pair[0].text.isNotEmpty && pair[1].text.isNotEmpty) return true;
    }
    return false;
  }

  void validator() {
    if (isAtLeastOnePartHasData() &&
        formController.stitchRateController.text.isNotEmpty) {
      Get.to(() => AddDesignView());
    } else {
      Get.snackbar(
        "Validation Error",
        "Any Field Can Not Be Empty",
        backgroundColor: Colors.red.withOpacity(.6),
        colorText: Colors.white,
        barBlur: 8,
      );
    }
  }

  void clearAllFields() {
    formController.resetForm();
    updateTotal();
  }
}
