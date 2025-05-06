import 'package:calculator/models/design_entity.dart';
import 'package:calculator/models/design_part_entity.dart';
import 'package:get/get.dart';

import 'design_form_controller.dart';
import 'storage_controller.dart';

class DesignDataController extends GetxController {
  final formCtrl = Get.find<DesignFormController>();
  final storageCtrl = Get.find<StorageController>();

  void saveDesign() {
    if (!formCtrl.validateForm()) {
      // Optional: show a snackbar or validation message
      return;
    }

    // 1. Create DesignEntity
    final design = DesignEntity(
      designNumber: formCtrl.designNumberController.text,
      designName: formCtrl.designNameController.text,
      stitchRate: formCtrl.stitchRateController.text,
      addOnPrice: formCtrl.addOnPriceController.text,
    );

    // 2. Create and add parts
    final cPallu = DesignPartEntity(
      type: "cPallu",
      head: formCtrl.cPalluHead.text,
      stitches: formCtrl.cPalluStitches.text,
    );

    final pallu = DesignPartEntity(
      type: "pallu",
      head: formCtrl.palluHead.text,
      stitches: formCtrl.palluStitches.text,
    );

    final stk = DesignPartEntity(
      type: "stk",
      head: formCtrl.stkHead.text,
      stitches: formCtrl.stkStitches.text,
    );

    final blz = DesignPartEntity(
      type: "blz",
      head: formCtrl.blzHead.text,
      stitches: formCtrl.blzStitches.text,
    );

    design.addParts(cPallu, pallu, stk, blz);

    // 3. Add images
    design.addImagePaths(formCtrl.selectedImages);

    // 4. Save to ObjectBox
    storageCtrl.saveDesign(design);
  }
}
