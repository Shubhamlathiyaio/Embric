import 'package:get/get.dart';
import 'package:calculator/models/design.dart';
import 'package:calculator/models/design_part.dart';

class DesignController extends GetxController {
  Rx<Design> design = Design(
    cPallu:
        DesignPart(type: DesignPartType.cPallu, head: '0.0', stitches: '0.0'),
    pallu: DesignPart(type: DesignPartType.pallu, head: '0.0', stitches: '0.0'),
    stk: DesignPart(type: DesignPartType.stk, head: '0.0', stitches: '0.0'),
    blz: DesignPart(type: DesignPartType.blz, head: '0.0', stitches: '0.0'),
    stitchRate: '0.0',
    addOnPrice: '0.0',
  ).obs;

  DesignPart get cPallu => design.value.cPallu;
  DesignPart get pallu => design.value.pallu;
  DesignPart get stk => design.value.stk;
  DesignPart get blz => design.value.blz;
  double get stitchRate => design.value.stitchRate;
  double get addOnPrice => design.value.addOnPrice;

  double get cPalluTotal => cPallu.stitches * cPallu.head * stitchRate;
  double get palluTotal => pallu.stitches * pallu.head * stitchRate;
  double get stkTotal => stk.stitches * stk.head * stitchRate;
  double get blzTotal => blz.stitches * blz.head * stitchRate;

  double finalTotal() =>
      cPallu.total(stitchRate) +
      pallu.total(stitchRate) +
      stk.total(stitchRate) +
      blz.total(stitchRate) +
      addOnPrice;
}
