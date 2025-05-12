import 'package:calculator/controllers/design_controller.dart';
import 'package:calculator/controllers/design_form_controller.dart';
import 'package:calculator/helpers/colors.dart';
import 'package:calculator/helpers/common_widget.dart';
import 'package:calculator/helpers/defaults.dart';
import 'package:calculator/models/design.dart';
import 'package:calculator/screens/home_common/big_text_field.dart';
import 'package:calculator/screens/home_common/design_part_input.dart';
import 'package:calculator/screens/home_common/header_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final designCtr = Get.find<DesignController>();
  final form = Get.find<DesignFormController>();
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Design? design = Get.arguments;
    if (design != null) {
      designCtr.setDesign(design);
    } else {
      designCtr.isEdit.value = false;
      designCtr.design.value = getDefaultDesign();
    }
    return Scaffold(
      backgroundColor: AppColors.bgcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            spacing: 20,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: CommonWidget().poppinsText(
                    text: "Embroidery Calculator",
                    textSize: 18.0,
                    textColor: AppColors.redcolor,
                    textWeight: FontWeight.w700),
              ),
              BigTextField(
                  label: "Stitch Rate", controller: form.stitchRateController),
              Center(
                child: SizedBox(
                  width: Get.width * 0.9,
                  child: Column(
                    spacing: 2.5,
                    children: [
                      HeaderRow(), // HeaderRow here
                      DesignPartInputRow(
                          label: "C-Pallu",
                          headController: form.cPalluHeadController,
                          stitchesController: form.cPalluStitchesController,
                          getTotal: () => designCtr.cPalluTotal),
                      DesignPartInputRow(
                          label: "Pallu",
                          headController: form.palluHeadController,
                          stitchesController: form.palluStitchesController,
                          getTotal: () => designCtr.palluTotal),
                      DesignPartInputRow(
                          label: "Skt",
                          headController: form.stkHeadController,
                          stitchesController: form.stkStitchesController,
                          getTotal: () => designCtr.stkTotal),
                      DesignPartInputRow(
                          label: "Blz",
                          headController: form.blzHeadController,
                          stitchesController: form.blzStitchesController,
                          getTotal: () => designCtr.blzTotal),
                    ],
                  ),
                ),
              ),
              BigTextField(
                  label: "Add on Prices",
                  controller: form.addOnPriceController),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SizedBox(
        height: Get.height * .2,
        child: TotalSummaryCard(
          getTotal: () => designCtr.grandTotal,
          onClear: designCtr.clearAllFields,
          onSave: () => designCtr.validator(),
        ),
      ),
    );
  }
}

class TotalSummaryCard extends StatelessWidget {
  final Rx<double> Function() getTotal;
  final VoidCallback onClear;
  final VoidCallback onSave;

  const TotalSummaryCard({
    super.key,
    required this.getTotal,
    required this.onClear,
    required this.onSave,
  });

  String getT() {
    final Rx<double> temp = getTotal();
    return temp.value.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.whitecolor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.softtextcolor.withOpacity(.2),
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget().poppinsText(
              text: 'Total Stitches:',
              textSize: 12.0,
              textWeight: FontWeight.w500,
            ),
            Obx(
              () => CommonWidget().poppinsText(
                text: getT(),
                textSize: 30.0,
                textWeight: FontWeight.bold,
                textColor: AppColors.blackcolor,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildButton('CLEAR', onClear),
                Obx(() => _buildButton(
                    Get.find<DesignController>().isEdit.value
                        ? 'UPDATE'
                        : 'SAVE',
                    onSave,
                    filled: true)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onTap, {bool filled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: Get.width * 0.43,
        decoration: BoxDecoration(
          color: filled ? AppColors.redcolor : null,
          border: filled ? null : Border.all(width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: CommonWidget().poppinsText(
            text: text,
            textSize: 14.0,
            textWeight: FontWeight.w700,
            textColor: filled ? AppColors.whitecolor : null,
          ),
        ),
      ),
    );
  }
}
