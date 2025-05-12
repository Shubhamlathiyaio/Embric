import 'package:calculator/models/design.dart';

import '../models/design_part.dart';

const double kStitchRate = 0.4;
const double kcPalluHead = 1.5;
const double kpalluHead = 7;
const double kstkHead = 11;
const double kblzHead = 1.5;

double getDefault(DesignPartType type) {
  switch (type) {
    case DesignPartType.cPallu:
      return kcPalluHead;
    case DesignPartType.pallu:
      return kpalluHead;
    case DesignPartType.stk:
      return kstkHead;
    case DesignPartType.blz:
      return kblzHead;
  }
}

Design getDefaultDesign() => Design(
  id : 0,
    stitchRate: kStitchRate,
    addOnPrice: 0,
    cPallu:
        DesignPart(type: DesignPartType.cPallu, head: kcPalluHead, stitches: 0),
    pallu:
        DesignPart(type: DesignPartType.pallu, head: kpalluHead, stitches: 0),
    stk: DesignPart(type: DesignPartType.stk, head: kstkHead, stitches: 0),
    blz: DesignPart(type: DesignPartType.blz, head: kblzHead, stitches: 0));
