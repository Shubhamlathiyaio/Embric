// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:calculator/controllers/design_details_contrller.dart';
import 'package:calculator/helpers/colors.dart';
import 'package:calculator/models/design.dart';
import 'package:calculator/models/image_path_entity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../helpers/common_widget.dart';

class DesignDetailView extends StatelessWidget {
  const DesignDetailView({super.key});

  BoxDecoration get _boxDecoration => BoxDecoration(
        color: AppColors.whitecolor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: AppColors.softtextcolor.withOpacity(.2),
            blurRadius: 5,
          )
        ],
      );

  @override
  Widget build(BuildContext context) {
    final Design design = Get.arguments;
    print("dek0000000000000000000 = ${design.imagePaths.length}");
    final DesignDetailController controller = Get.put(DesignDetailController());

    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      appBar: AppBar(
        backgroundColor: AppColors.bgcolor,
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/cal', arguments: design);
              },
              icon: Icon(Icons.edit)),
          SizedBox(width: 10)
        ],
      ),
      body: SingleChildScrollView(
        child: (Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "#",
                      style: TextStyle(fontSize: 36, color: Colors.grey),
                    ),
                    CommonWidget().poppinsText(
                        text: design.designNumber,
                        textWeight: FontWeight.bold,
                        textSize: 36),
                  ],
                )),
            const SizedBox(height: 10),
            Center(
              child: Obx(() => Container(
                    height: Get.height * 0.5,
                    width: Get.width * 0.9,
                    decoration: _boxDecoration,
                    child: Image.file(
                      File(design
                          .imagePaths[controller.selectedImageIndex.value].path),
                      fit: BoxFit.cover,
                    ),
                  )),
            ),
            const SizedBox(height: 10),
            _buildHorizontalGrid(design.imagePaths, controller),
            const SizedBox(height: 15),
            _buildDetailCard(design),
          ],
        )),
      ),
    );
  }

  Widget _buildHorizontalGrid(
      List<ImagePathEntity> images, DesignDetailController controller) {
    return SizedBox(
      height: 100,
      child: GridView.builder(
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => controller.updateIndex(index),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10), // 👈 Rounded corners
              child: Container(
                width: 100,
                decoration: _boxDecoration,
                child: Image.file(
                  File(images[index].path),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailCard(Design design) {
    return Container(
      width: Get.width * 0.9,
      padding: const EdgeInsets.all(10),
      decoration: _boxDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonWidget().poppinsText(
            text: "#SP${design.designNumber}",
            textSize: 10.0,
            textColor: AppColors.softtextcolor,
            textWeight: FontWeight.w700,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget().poppinsText(
                text: design.designName,
                textSize: 18.0,
                textColor: AppColors.blackcolor,
                textWeight: FontWeight.w700,
              ),
              CommonWidget().poppinsText(
                text: "₹${design.grandTotal.toStringAsFixed(2)}",
                textSize: 16.0,
                textColor: AppColors.blackcolor,
                textWeight: FontWeight.w700,
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Stitch: ',
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400, fontSize: 12),
                ),
                const TextSpan(
                  text: '1250',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          CommonWidget().poppinsText(
            text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry...",
            textSize: 12.0,
            textMaxline: 5,
            textOverFlow: TextOverflow.ellipsis,
            textColor: AppColors.softtextcolor,
            textWeight: FontWeight.w400,
          ),
        ],
      ),
    );
  }
}
