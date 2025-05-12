import 'package:calculator/controllers/design_form_controller.dart';
import 'package:calculator/helpers/colors.dart';
import 'package:calculator/helpers/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DesignPartInputRow extends StatelessWidget {
  final String label;
  final TextEditingController stitchesController;
  final TextEditingController headController;
  final Rx<double> Function() getTotal;

  const DesignPartInputRow({
    super.key,
    required this.label,
    required this.stitchesController,
    required this.headController,
    required this.getTotal,
  });

  String getT() {
    final Rx<double> total = getTotal();
    if(total.value==0)return '0';
    String sTotal = total.toString();
    if (sTotal.contains('.')) if (sTotal.split('.')[1].length > 2) return total.value.toStringAsFixed(2);    
    return total.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width * 0.15,
          child: Text(label),
        ),
        CommonFrameContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CommonInputField(
                controller: stitchesController,
                onChange: (value) => stitchesController.text =
                    DesignFormController().sanitizeDoubleInput(value),
              ),
              Container(height: 10, width: 1, color: Colors.black),
              CommonInputField(
                  controller: headController,
                  onChange: (value) => headController.text =
                      DesignFormController().sanitizeDoubleInput(value)),
            ],
          ),
        ),
        Text("="),
        CommonFrameContainer(
          width: Get.width * .18,
          child: Obx(
            () => CommonWidget()
                .poppinsText(text: getT(), textWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

class CommonInputField extends StatelessWidget {
  final TextEditingController controller;
  final Function onChange;

  const CommonInputField({
    super.key,
    required this.controller,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.22,
      height: 50,
      child: Center(
        child: TextFormField(
          onChanged: (value) => onChange(value),
          keyboardType: TextInputType.number,
          controller: controller,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "00",
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.softtextcolor.withOpacity(.5),
            ),
          ),
        ),
      ),
    );
  }
}

class CommonFrameContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double borderWidth;
  final Color? borderColor;
  final double borderRadius;

  const CommonFrameContainer({
    super.key,
    required this.child,
    this.width,
    this.height = 50,
    this.padding,
    this.color,
    this.borderWidth = 2,
    this.borderColor,
    this.borderRadius = 10,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? Get.width * 0.5,
      padding: padding,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? AppColors.softtextcolor,
          width: borderWidth,
        ),
        color: color ?? AppColors.whitecolor,
      ),
      child: child,
    );
  }
}
