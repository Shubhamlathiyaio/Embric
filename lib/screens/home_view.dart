import 'package:calculator/controllers/design_controller.dart';
import 'package:calculator/controllers/design_form_controller.dart';
import 'package:calculator/helpers/colors.dart';
import 'package:calculator/helpers/common_widget.dart';
import 'package:calculator/screens/home_common/design_part_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final design = Get.find<DesignController>();
  final form = Get.find<DesignFormController>();

  @override
  Widget build(BuildContext context) {
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
              commonBigField(
                  label: "Stitch Rate",
                  controller: form.stitchRateController,
                  onChanged: design.update),
              Center(
                child: SizedBox(
                  width: Get.width * 0.9,
                  child: Column(
                    spacing: 2.5,
                    children: [
                      _headRow(),
                      DesignPartInputRow(
                          label: "C-Pallu",
                          headController: form.cPalluHead,
                          stitchesController: form.cPalluStitches,
                          getTotal: () => design.cPalluTotal),
                      DesignPartInputRow(
                          label: "Pallu",
                          headController: form.palluHead,
                          stitchesController: form.palluStitches,
                          getTotal: () => design.palluTotal),
                      DesignPartInputRow(
                          label: "Skt",
                          headController: form.stkHead,
                          stitchesController: form.stkStitches,
                          getTotal: () => design.stkTotal),
                      DesignPartInputRow(
                          label: "Blz",
                          headController: form.blzHead,
                          stitchesController: form.blzStitches,
                          getTotal: () => design.blzTotal),
                    ],
                  ),
                ),
              ),
              commonBigField(
                  label: "Add on Prices",
                  controller: form.addOnPriceController,
                  onChanged: design.update),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: SizedBox(
        height: Get.height * .2,
        child: TotalSummaryCard(
          getTotal: () => design.grandTotal,
          onClear: design.clearAllFields,
          onSave: () => design.validator(),
        ),
      ),
    );
  }

  Widget _headRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width * 0.12,
          child: CommonWidget().poppinsText(
              text: "Name", textSize: 14.0, textWeight: FontWeight.w400),
        ),
        SizedBox(
          width: Get.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget().poppinsText(
                  text: "Stitches",
                  textSize: 14.0,
                  textWeight: FontWeight.w400),
              CommonWidget().poppinsText(
                  text: "Head", textSize: 14.0, textWeight: FontWeight.w400),
            ],
          ),
        ),
        SizedBox(
          width: Get.width * 0.18,
          child: Center(
            child: CommonWidget().poppinsText(
                text: "Total", textSize: 14.0, textWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }

  Widget commonBigField({
    required String label,
    required TextEditingController controller,
    required VoidCallback onChanged,
  }) {
    return Center(
      child: Container(
        width: Get.width * 0.9,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.whitecolor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.softtextcolor.withOpacity(.2),
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidget().poppinsText(
              text: "$label:",
              textSize: 12.0,
              textWeight: FontWeight.w500,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: controller,
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "00.00",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.softtextcolor.withOpacity(.5),
                ),
              ),
              onChanged: (_) => onChanged(),
            ),
          ],
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
              text: "Total Stitches:",
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
                _buildButton("CLEAR", onClear),
                _buildButton("SAVE", onSave, filled: true),
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
