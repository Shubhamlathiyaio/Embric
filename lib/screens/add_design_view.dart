import 'dart:io';
import 'package:calculator/controllers/design_controller.dart';
import 'package:calculator/controllers/design_form_controller.dart';
import 'package:calculator/controllers/nav_controller.dart';
import 'package:calculator/helpers/colors.dart';
import 'package:calculator/resources/commons/common_get_snackbar.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../helpers/common_widget.dart';

class AddDesignView extends StatelessWidget {
  AddDesignView({super.key});
  final DesignController design = Get.find<DesignController>();
  final form = Get.find<DesignFormController>();

  @override
  Widget build(BuildContext context) {
    print("${form.selectedImages}");
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: AppBar(
        title: CommonWidget().poppinsText(
          text: "Add Design",
          textSize: 18.0,
          textColor: AppColors.redcolor,
          textWeight: FontWeight.w700,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildDesignInputCard(),
              const SizedBox(height: 15),
              _buildUploadButton(),
              const SizedBox(height: 10),
              _buildImagePreviewList(),
              const SizedBox(height: 20),
              _buildSummaryCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesignInputCard() {
    return Center(
      child: Container(
        width: Get.width * 0.9,
        padding: const EdgeInsets.all(10),
        decoration: _boxDecoration(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Design Number on the left (balanced size)
            _buildTextFieldColumn("Design No:", form.designNumberController,
                TextInputType.number, Get.width * 0.25, true),
            _divider(),
            // Design Name on the right (balanced size)
            _buildTextFieldColumn("Design Name:", form.designNameController,
                TextInputType.text, Get.width * 0.55, false),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldColumn(String label, TextEditingController controller,
      TextInputType keyboardType, double width, bool isSmall) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget().poppinsText(
            text: label,
            textSize: 12.0,
            textWeight: FontWeight.w500,
          ),
          TextFormField(
            controller: controller,
            style: TextStyle(
              fontSize: isSmall ? 24 : 18, // Adjust font size for balance
              fontWeight: FontWeight.bold,
            ),
            keyboardType: keyboardType,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText:
                  isSmall ? "00" : "Enter Design Name", // Adjust hint text
              hintStyle: GoogleFonts.poppins(
                fontSize: isSmall ? 24 : 18, // Consistent font size adjustments
                fontWeight: FontWeight.bold,
                color: AppColors.softtextcolor.withOpacity(.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      height: 50,
      width: 1,
      color: AppColors.softtextcolor,
    );
  }

  Widget _buildUploadButton() {
    return GestureDetector(
      onTap: () => form.selectedImages.length < 5
          ? pickImage(form.selectedImages)
          : Get.snackbar(
              backgroundColor: Colors.black54,
              barBlur: 8,
              colorText: Colors.white,
              "Can Not Upload More",
              "You can not uplonde more then 5 images"),
      child: Container(
        height: 50,
        width: Get.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.redcolor),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, color: AppColors.redcolor),
            const SizedBox(width: 10),
            CommonWidget().poppinsText(
              text: "Upload Design Image",
              textSize: 12.0,
              textWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(List<String> imageList) async {
    final ImagePicker picker = ImagePicker();

    if (Platform.isAndroid) {
      final sdkInt = await DeviceInfoPlugin()
          .androidInfo
          .then((info) => info.version.sdkInt);

      if (sdkInt < 33) {
        // Android < 13 needs storage permission
        var status = await Permission.storage.request();
        if (!status.isGranted) {
          openAppSettings();
          return;
        }
      }
      // Android >= 13 does NOT need storage permission to pick image from gallery
    } else {
      // iOS needs photo permission
      var status = await Permission.photos.request();
      if (!status.isGranted) {
        openAppSettings();
        return;
      }
    }

    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && imageList.length < 5) {
      imageList.add(pickedFile.path);
    }
  }

  Widget _buildImagePreviewList() {
    // max 4 images + 1 add icon
    final showAddIcon = form.selectedImages.length < 5;

    return Obx(
      () => SizedBox(
        height: 75,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: form.selectedImages.length +
              (form.selectedImages.length < 5 ? 1 : 0),
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            if (showAddIcon && index == form.selectedImages.length) {
              // Add icon goes to the end
              return GestureDetector(
                onTap: () => pickImage(form.selectedImages),
                child: Container(
                  width: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.whitecolor,
                  ),
                  child: Center(
                    child: Icon(Icons.add, size: 30, color: AppColors.redcolor),
                  ),
                ),
              );
            } else {
              // Show selected images first
              final imagePath = form.selectedImages[index];
              return Stack(
                children: [
                  Container(
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                        image: FileImage(File(imagePath)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => form.selectedImages.removeAt(index),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.black.withOpacity(0.5),
                        child: const Icon(Icons.close,
                            size: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Center(
      child: Container(
        width: Get.width * 0.9,
        padding: const EdgeInsets.all(10),
        decoration: _boxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget().poppinsText(
              text: "Total Stitches:",
              textSize: 12.0,
              textWeight: FontWeight.w500,
            ),
            Obx(() => CommonWidget().poppinsText(
                  text: design.grandTotal.value.toStringAsFixed(1),
                  textWeight: FontWeight.bold,
                  textColor: AppColors.blackcolor,
                  textSize: 30.0,
                )),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _actionButton("CANCEL", () => Get.back()),
                Obx(
                  () => _actionButton(
                    design.isEdit.value ? "UPDATE" : "SAVE",
                    () {
                      if (form.designNumberController.text != '' &&
                          form.selectedImages.isNotEmpty) {
                        design.updateTotal();
                        design.isEdit.value
                            ? design.updateDesign()
                            : design.saveDesign();
                        Get.back();
                        Get.back();
                        Get.back();

                        design.isEdit.value
                            ? CommonSnackbar.customSuccessSnackbar(
                                "Updated Successfully")
                            : CommonSnackbar.customSuccessSnackbar(
                                "Save Successfully");
                        Get.find<NavController>().selectedIndex.value = 0;
                      } else {
                        CommonSnackbar.errorSnackbar();
                      }
                    },
                    color: AppColors.redcolor,
                    textColor: AppColors.whitecolor,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: AppColors.whitecolor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: AppColors.softtextcolor.withOpacity(.2),
          blurRadius: 5,
        )
      ],
    );
  }

  Widget _actionButton(String label, VoidCallback onTap,
      {Color? color, Color? textColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        width: Get.width * 0.35,
        decoration: BoxDecoration(
          color: color ?? Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 2, color: color ?? Colors.black),
        ),
        child: Center(
          child: CommonWidget().poppinsText(
            text: label,
            textSize: 14.0,
            textWeight: FontWeight.w700,
            textColor: textColor ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
