// lib/mappers/design_mapper.dart

import '../models/design.dart';
import '../models/design_entity.dart';
import '../models/design_part.dart';
import '../models/design_part_entity.dart';

/// Maps [Design] to [DesignEntity]
DesignEntity designToEntity(Design design) {
  final entity = DesignEntity(
    designNumber: design.designNumber,
    designName: design.designName,
    stitchRate: design.stitchRate.toString(),
    addOnPrice: design.addOnPrice.toString(),
  );

  entity.addParts(
    partToEntity(design.cPallu),
    partToEntity(design.pallu),
    partToEntity(design.stk),
    partToEntity(design.blz),
  );

  entity.addImagePaths(design.imagePaths);
  return entity;
}

DesignPart _mapPart(DesignPartEntity? entity, DesignPartType type) {
  return entity == null ? DesignPart(type: type) : entityToPart(entity);
}

/// Maps [DesignEntity] to [Design]
Design entityToDesign(DesignEntity entity) {
  return Design(
    designNumber: entity.designNumber,
    designName: entity.designName,
    stitchRate: double.tryParse(entity.stitchRate) ?? 0,
    addOnPrice: double.tryParse(entity.addOnPrice) ?? 0,
    cPallu: _mapPart(entity.cPallu.target, DesignPartType.cPallu),
    pallu: _mapPart(entity.pallu.target, DesignPartType.pallu),
    stk: _mapPart(entity.stk.target, DesignPartType.stk),
    blz: _mapPart(entity.blz.target, DesignPartType.blz),
    imagePaths: entity.imagePaths.map((e) => e.path).toList(),
  );
}

/// Maps [DesignPart] to [DesignPartEntity]
DesignPartEntity partToEntity(DesignPart part) {
  return DesignPartEntity(
    type: part.type.name,
    head: _orString(part.head),
    stitches: _orString(part.stitches),
  );
}

String _orString(double value) => value == 0 ? '' : value.toString();

/// Maps [DesignPartEntity] to [DesignPart]
DesignPart entityToPart(DesignPartEntity entity) {
  print(DesignPartType.values.byName(entity.type));
  return DesignPart(
    type: DesignPartType.values.byName(entity.type),
    head: double.tryParse(entity.head) ?? 0,
    stitches: double.tryParse(entity.stitches) ?? 0,
  );
}
