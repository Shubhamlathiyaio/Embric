import '../models/design_part.dart';

double getDefault(DesignPartType type) {
  switch (type) {
    case DesignPartType.cPallu:return 1.5;
    case DesignPartType.pallu:return 7;
    case DesignPartType.stk:return 11;
    case DesignPartType.blz:return 1.5;
  }
}
