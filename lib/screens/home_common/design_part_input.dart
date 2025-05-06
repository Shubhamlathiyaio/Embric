import 'package:calculator/helpers/colors.dart';
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
    final Rx<double> temp = getTotal();
    return temp.value.toStringAsFixed(2);
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
              CommonInputField(controller: stitchesController),
              Container(height: 10, width: 1, color: Colors.black),
              CommonInputField(controller: headController),
            ],
          ),
        ),
        Text("="),
        CommonFrameContainer(
          width: Get.width * .18,
          child: Obx(
            () => Text(getT()),
          ),
        ),
      ],
    );
  }
}


class CommonInputField extends StatelessWidget {
  final TextEditingController controller;

  const CommonInputField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.22,
      height: 50,
      child: Center(
        child: TextFormField(
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
