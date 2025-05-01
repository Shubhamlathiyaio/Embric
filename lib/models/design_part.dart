import 'package:flutter/material.dart';

enum DesignPartType { cPallu, pallu, stk, blz }

class DesignPart {
  final DesignPartType type;
  final TextEditingController stitchesController;
  final TextEditingController headController;

  DesignPart({
    required this.type,
    String stitches = '',
    String head = '',
  })  : stitchesController = TextEditingController(text: stitches),
        headController = TextEditingController(text: head);

  double get stitches => double.tryParse(stitchesController.text) ?? 0;
  double get head => double.tryParse(headController.text) ?? 0;

  double total(double stitchRate) => stitches * head * stitchRate;
}

