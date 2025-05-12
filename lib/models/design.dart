// lib/models/design.dart

import 'package:calculator/models/image_path_entity.dart';

import 'design_part.dart';

class Design {
  int? id;
  final String designNumber;
  final String designName;
  final double stitchRate;
  final double addOnPrice;
  final DesignPart cPallu;
  final DesignPart pallu;
  final DesignPart stk;
  final DesignPart blz;
  final List<ImagePathEntity> imagePaths;

  Design({
    this.id,
    this.designNumber = "",
    this.designName = "",
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

  Design copy() => Design(
    id :id,
        cPallu: cPallu.copy(),
        pallu: pallu.copy(),
        stk: stk.copy(),
        blz: blz.copy(),
        stitchRate: stitchRate,
        addOnPrice: addOnPrice,
        designName: designName,
        designNumber: designNumber,
        imagePaths: List.from(imagePaths),
      );
  @override
  String toString() {
    return 'ID = $id Name = $designName,';
  }
}
