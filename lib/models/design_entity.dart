import 'package:calculator/objectbox.g.dart';
import 'design_part_entity.dart';
import 'image_path_entity.dart';

@Entity()
class DesignEntity {
  int id = 0;

  String designNumber;
  String designName;
  String stitchRate;
  String addOnPrice;

  @Backlink()
  final imagePaths = ToMany<ImagePathEntity>();
  final cPallu = ToOne<DesignPartEntity>();
  final pallu = ToOne<DesignPartEntity>();
  final stk = ToOne<DesignPartEntity>();
  final blz = ToOne<DesignPartEntity>();

  DesignEntity({
    this.id = 0,
    required this.designNumber,
    required this.designName,
    required this.stitchRate,
    required this.addOnPrice,
  });

  void addParts(
    DesignPartEntity cPalluPart,
    DesignPartEntity palluPart,
    DesignPartEntity stkPart,
    DesignPartEntity blzPart,
  ) {
    cPallu.target = cPalluPart;
    pallu.target = palluPart;
    stk.target = stkPart;
    blz.target = blzPart;
  }

  void addImagePaths(List<ImagePathEntity> paths) {
    imagePaths.clear();
    for (var path in paths) {
      imagePaths.add(path);
    }
  }
}
