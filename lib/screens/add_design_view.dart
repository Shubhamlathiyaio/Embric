import 'dart:io';

import 'package:calculator/controllers/design_controller.dart';
import 'package:calculator/helpers/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../helpers/common_widget.dart';

class AddDesignView extends StatelessWidget {
  AddDesignView({super.key});
  final design = Get.find<DesignController>();
  final List<String> designImages = [];

  @override
  Widget build(BuildContext context) {
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
              _buildImagePreviewList(designImages),
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
            _buildTextFieldColumn("Design No:"),
            _divider(),
            _buildTextFieldColumn("Design Name:"),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldColumn(String label) {
    return SizedBox(
      width: Get.width * 0.35,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget().poppinsText(
            text: label,
            textSize: 12.0,
            textWeight: FontWeight.w500,
          ),
          TextFormField(
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "00",
              hintStyle: GoogleFonts.poppins(
                fontSize: 30,
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
    return Container(
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
    );
  }

  Widget _buildImagePreviewList(List<String> images) {
    // max 4 images + 1 add icon
    final showAddIcon = images.length < 5;
    final itemCount = images.length + (showAddIcon ? 1 : 0);

    return SizedBox(
      height: 75,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          // If it's the add icon card
          if (showAddIcon && index == 0) {
            return GestureDetector(
              onTap: () async {
                final XFile? pickedFile =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (pickedFile != null) {
                  // Check if the number of images is less than 5 before adding
                  if (design.designImages.length < 5) {
                    design.designImages.add(pickedFile.path);
                  }
                }
              },
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
          }

          // Image card
          final imageIndex = showAddIcon ? index - 1 : index;
          final imagePath = images[imageIndex];

          return Container(
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: FileImage(File(imagePath)), // assumes local image path
                fit: BoxFit.cover,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.softtextcolor.withOpacity(.2),
                  blurRadius: 5,
                ),
              ],
            ),
          );
        },
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
                _actionButton("SAVE", () {
                  // Save logic
                  // you can call a method from controller here
                  design.updateTotal(); // example
                }, color: AppColors.redcolor, textColor: AppColors.whitecolor),
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
