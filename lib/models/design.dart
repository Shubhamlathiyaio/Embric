// lib/models/design.dart

import 'design_part.dart';

class Design {
  final String designNumber;
  final String designName;
  final double stitchRate;
  final double addOnPrice;
  final DesignPart cPallu;
  final DesignPart pallu;
  final DesignPart stk;
  final DesignPart blz;
  final List<String> imagePaths;

  Design({
    this.designNumber="",
    this.designName="",
    required this.stitchRate,
    required this.addOnPrice,
    required this.cPallu,
    required this.pallu,
    required this.stk,
    required this.blz,
    this.imagePaths = const [],
  });

  double get cPalluTotal => cPallu.total(stitchRate);
  double get palluTotal => pallu.total(stitchRate);
  double get stkTotal => stk.total(stitchRate);
  double get blzTotal => blz.total(stitchRate);

  double get grandTotal =>
      cPalluTotal + palluTotal + stkTotal + blzTotal + addOnPrice;
}
