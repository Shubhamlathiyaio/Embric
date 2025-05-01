import 'package:calculator/models/design_part.dart';
import 'package:flutter/material.dart';

class Design {
  final DesignPart cPallu;
  final DesignPart pallu;
  final DesignPart stk;
  final DesignPart blz;

  final TextEditingController stitchRateController;
  final TextEditingController addOnPriceController;

  Design({
    required this.cPallu,
    required this.pallu,
    required this.stk,
    required this.blz,
    String stitchRate = "0",
    String addOnPrice = "0",
  })  : stitchRateController = TextEditingController(text: stitchRate),
        addOnPriceController = TextEditingController(text: addOnPrice);

  double get stitchRate => double.tryParse(stitchRateController.text) ?? 0;
  double get addOnPrice => double.tryParse(addOnPriceController.text) ?? 0;
}
