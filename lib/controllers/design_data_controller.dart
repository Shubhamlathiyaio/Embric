import 'package:calculator/models/design_entity.dart';
import 'package:calculator/models/design_part_entity.dart';
import 'package:calculator/models/image_path_entity.dart';
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
    final designEntity = DesignEntity(
      designNumber: formCtrl.designNumberController.text,
      designName: formCtrl.designNameController.text,
      stitchRate: formCtrl.stitchRateController.text,
      addOnPrice: formCtrl.addOnPriceController.text,
    );

    // 2. Create and add parts
    final cPallu = DesignPartEntity(
      type: "cPallu",
      head: formCtrl.cPalluHeadController.text,
      stitches: formCtrl.cPalluStitchesController.text,
    );

    final pallu = DesignPartEntity(
      type: "pallu",
      head: formCtrl.palluHeadController.text,
      stitches: formCtrl.palluStitchesController.text,
    );

    final stk = DesignPartEntity(
      type: "stk",
      head: formCtrl.stkHeadController.text,
      stitches: formCtrl.stkStitchesController.text,
    );

    final blz = DesignPartEntity(
      type: "blz",
      head: formCtrl.blzHeadController.text,
      stitches: formCtrl.blzStitchesController.text,
    );

    designEntity.addParts(cPallu, pallu, stk, blz);
    final images = [for(String e in formCtrl.selectedImages) ImagePathEntity(path: e)];
    
    designEntity.addImagePaths(images);
    // 3. Add images
    // storageCtrl.removeImagePathsFromDB(design);

    // 4. Save to ObjectBox
    storageCtrl.saveDesign(designEntity);
  }
}
