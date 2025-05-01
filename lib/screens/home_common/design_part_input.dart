import 'package:calculator/helpers/colors.dart';
import 'package:calculator/helpers/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:calculator/models/design_part.dart';

class DesignPartInputRow extends StatelessWidget {
  final String label;
  final DesignPart part;
  final double total;
  final VoidCallback onChanged;

  const DesignPartInputRow({
    super.key,
    required this.label,
    required this.part,
    required this.total,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: Get.width * 0.15,
          child: CommonWidget().poppinsText(text: label),
        ),
        CommonFrameContainer(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: Get.width * 0.22,
                height: 50,
                child: Center(
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: part.stitchesController,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "00",
                      hintStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.softtextcolor.withOpacity(.5),
                      ),
                    ),
                    onChanged: (_) => onChanged(),
                  ),
                ),
              ),
              Container(height: 10, width: 1, color: AppColors.blackcolor),
              SizedBox(
                width: Get.width * 0.22,
                height: 50,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: part.headController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "00",
                    hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.softtextcolor.withOpacity(.5),
                    ),
                  ),
                  onChanged: (_) => onChanged(),
                ),
              )
            ],
          ),
        ),
        CommonWidget().poppinsText(
          text: "=",
          textSize: 14.0,
          textWeight: FontWeight.w400,
        ),
        CommonFrameContainer(
          width: Get.width * .18,
          child: CommonWidget().poppinsText(
            text: total.toStringAsFixed(2),
            textSize: 16.0,
            textWeight: FontWeight.w700,
          ),
        ),
      ],
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
