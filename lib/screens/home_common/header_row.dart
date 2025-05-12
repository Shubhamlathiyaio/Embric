// Create a new file for the widget (e.g., header_row.dart) to keep it modular
import 'package:flutter/material.dart';
import 'package:calculator/helpers/common_widget.dart';

class HeaderRow extends StatelessWidget {
  const HeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.12,
          child: CommonWidget().poppinsText(
            text: "Name", 
            textSize: 14.0, 
            textWeight: FontWeight.w400
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonWidget().poppinsText(
                text: "Stitches",
                textSize: 14.0,
                textWeight: FontWeight.w400,
              ),
              CommonWidget().poppinsText(
                text: "Head", 
                textSize: 14.0, 
                textWeight: FontWeight.w400
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.18,
          child: Center(
            child: CommonWidget().poppinsText(
              text: "Total", 
              textSize: 14.0, 
              textWeight: FontWeight.w400
            ),
          ),
        ),
      ],
    );
  }
}
