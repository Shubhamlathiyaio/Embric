import 'package:objectbox/objectbox.dart';
import 'package:calculator/models/design_part.dart';


@Entity()
class DesignPartEntity {
  int id = 0;
  String type;
  String head;
  String stitches;

  DesignPartEntity({
    required this.type,
    required this.head,
    required this.stitches,
  });

  factory DesignPartEntity.fromDesignPart(DesignPart part, String head, String stitches) {
    return DesignPartEntity(
      type: part.type.name,
      head: head,
      stitches: stitches,
    );
  }
}
