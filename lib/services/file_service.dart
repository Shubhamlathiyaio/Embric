import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class FileService {
  Future<String> saveImageToLocalDirectory(String originalPath) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(originalPath);
    final savedImage = File('${appDir.path}/$fileName');

    return await File(originalPath).copy(savedImage.path).then((f) => f.path);
  }
}
