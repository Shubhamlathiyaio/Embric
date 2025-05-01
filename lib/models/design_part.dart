import 'package:flutter/material.dart';

enum DesignPartType { cPallu, pallu, stk, blz }

class DesignPart {
  final DesignPartType type;
  final TextEditingController stitchesController;
  final TextEditingController headController;
  final VoidCallback? onChanged;

  DesignPart({
    required this.type,
    String stitches = '',
    String head = '',
    this.onChanged,
  })  : stitchesController = TextEditingController(text: stitches),
        headController = TextEditingController(text: head) {
    stitchesController.addListener(_triggerChange);
    headController.addListener(_triggerChange);
  }

  double get stitches => double.tryParse(stitchesController.text) ?? 0;
  double get head => double.tryParse(headController.text) ?? 0;

  double total(double stitchRate) => stitches * head * stitchRate / 1000;

  void _triggerChange() {
    if (onChanged != null) {
      onChanged!();
    }
  }

  void dispose() {
    stitchesController.dispose();
    headController.dispose();
  }
}
