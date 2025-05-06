import 'package:objectbox/objectbox.dart';


@Entity()
class ImagePathEntity {
  int id = 0;
  String path;

  ImagePathEntity({required this.path});
}
