// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:image_picker/image_picker.dart';

Future<List<Uint8List>> getImagesBytes(List<XFile> images) async {
  List<Uint8List> files = [];
  for (final image in images) {
    final bytes = await image.readAsBytes();
    files.add(bytes);
  }
  return files;
}
