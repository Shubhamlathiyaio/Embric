import 'package:calculator/controllers/design_form_controller.dart';
import 'package:calculator/controllers/design_mapper.dart';
import 'package:calculator/controllers/storage_controller.dart';
import 'package:calculator/helpers/defaults.dart';
import 'package:calculator/models/design_entity.dart';
import 'package:calculator/screens/add_design_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/design.dart';
import '../models/design_part.dart';

class DesignController extends GetxController {
  final DesignFormController formController = Get.find<DesignFormController>();

  final Rx<Design> design = Design(
    cPallu: DesignPart(
        type: DesignPartType.cPallu, head: getDefault(DesignPartType.cPallu)),
    pallu: DesignPart(
        type: DesignPartType.pallu, head: getDefault(DesignPartType.pallu)),
    stk: DesignPart(
        type: DesignPartType.stk, head: getDefault(DesignPartType.stk)),
    blz: DesignPart(
        type: DesignPartType.blz, head: getDefault(DesignPartType.blz)),
    stitchRate: 0.40,
    addOnPrice: 0,
  ).obs;

  // RxList<String> designImages = <String>[].obs;

  double get stitchRate => double.tryParse(formController.stitchRateController.text) ?? 0;
  double get addOnPrice => double.tryParse(formController.addOnPriceController.text) ?? 0;

  String get designNumber => formController.designNumberController.text;
  String get designName => formController.designNameController.text;

  // Totals
  final cPalluTotal = 0.0.obs;
  final palluTotal = 0.0.obs;
  final stkTotal = 0.0.obs;
  final blzTotal = 0.0.obs;
  final grandTotal = 0.0.obs;

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
      formController.cPalluHead,
      formController.cPalluStitches,
      formController.palluHead,
      formController.palluStitches,
      formController.stkHead,
      formController.stkStitches,
      formController.blzHead,
      formController.blzStitches,
    ]) {
      controller.addListener(updateTotal);
    }
  }

void _updatePartValues(DesignPart part, TextEditingController headCtrl, TextEditingController stitchesCtrl) {
  part.head = double.tryParse(headCtrl.text) ?? 0;
  part.stitches = double.tryParse(stitchesCtrl.text) ?? 0;
}


  void updateTotal() {
  _updatePartValues(design.value.cPallu, formController.cPalluHead, formController.cPalluStitches);
  _updatePartValues(design.value.pallu, formController.palluHead, formController.palluStitches);
  _updatePartValues(design.value.stk, formController.stkHead, formController.stkStitches);
  _updatePartValues(design.value.blz, formController.blzHead, formController.blzStitches);

  cPalluTotal.value = design.value.cPallu.total(stitchRate);
  palluTotal.value = design.value.pallu.total(stitchRate);
  stkTotal.value = design.value.stk.total(stitchRate);
  blzTotal.value = design.value.blz.total(stitchRate);
  grandTotal.value = finalTotal();
}


  double finalTotal() => cPalluTotal.value + palluTotal.value + stkTotal.value + blzTotal.value + addOnPrice;

  void saveDesign() {
    final designEntity = DesignEntity(
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

    designEntity.addImagePaths(formController.selectedImages);
    Get.find<StorageController>().saveDesign(designEntity);
  }

  bool isAllPartHasData() {
    for (var pair in [
      [formController.cPalluHead, formController.cPalluStitches],
      [formController.palluHead, formController.palluStitches],
      [formController.stkHead, formController.stkStitches],
      [formController.blzHead, formController.blzStitches],
    ]) {
      if (pair[0].text.isEmpty || pair[1].text.isEmpty) return false;
    }
    return true;
  }

  void validator() {
    if (isAllPartHasData() && formController.stitchRateController.text.isNotEmpty) {
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

  // final ImagePicker _picker = ImagePicker();

  // Future<void> pickImage() async {
  //   final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null && formController.selectedImages.length < 5) {
  //     formController.selectedImages.add(pickedFile.path);
  //   }
  // }

  // void removeImage(int index) {
  //   formController.selectedImages.removeAt(index);
  // }

  void clearAllFields() {
    formController.clearForm();
    updateTotal();
  }
}
