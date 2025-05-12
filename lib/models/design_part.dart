// lib/models/design_part.dart

import 'package:flutter/material.dart';

enum DesignPartType { cPallu, pallu, stk, blz }

class DesignPart {
  final DesignPartType type;
  double head;
  double stitches;
  final TextEditingController stitchesController;
  final TextEditingController headController;
  DesignPart({
    required this.type,
    this.head = 0,
    this.stitches = 0,
  })  : stitchesController = TextEditingController(),
        headController = TextEditingController();

  double total(double stitchRate) {
    final h = head;
    final s = stitches;
    return h * s * stitchRate / 1000;
  }
}

extension DesignPartCopy on DesignPart {
  DesignPart copy() {
    return DesignPart(
      type: type,
      stitches: stitches,
      head: head,
    );
  }
}
