import 'package:calculator/controllers/storage_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

void showDeleteDialog(BuildContext context, int designId) {
  final storageController = Get.find<StorageController>();
  Get.defaultDialog(
    
    title: "Confirm Deletion",
    middleText: "Are you sure you want to delete this design?",
    textCancel: "No",
    textConfirm: "Yes",
    confirmTextColor: Colors.white,
    onConfirm: () {
      storageController.deleteDesign(designId);
      storageController.update();
      
      Get.snackbar("Deleted", "Design has been deleted");
    },
  );
}
