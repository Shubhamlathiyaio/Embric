// Create a new file for this widget (e.g., big_text_field.dart)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:calculator/helpers/common_widget.dart';
import 'package:calculator/helpers/colors.dart';

class BigTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const BigTextField(
      {super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
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
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "00.00",
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: AppColors.softtextcolor.withOpacity(.5),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
