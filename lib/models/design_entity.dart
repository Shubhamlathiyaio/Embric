import 'package:objectbox/objectbox.dart';
import 'design_part_entity.dart';
import 'image_path_entity.dart';

@Entity()
class DesignEntity {
  int id = 0;

  String designNumber;
  String designName;
  String stitchRate;
  String addOnPrice;

  final imagePaths = ToMany<ImagePathEntity>();
  final cPallu = ToOne<DesignPartEntity>();
  final pallu = ToOne<DesignPartEntity>();
  final stk = ToOne<DesignPartEntity>();
  final blz = ToOne<DesignPartEntity>();

  DesignEntity({
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


  void addImagePaths(List<String> paths) {
    imagePaths.clear();
    imagePaths.addAll(paths.map((path) => ImagePathEntity(path: path)));
  }
}
