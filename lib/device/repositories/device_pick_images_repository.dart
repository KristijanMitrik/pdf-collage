// Dart imports:
import 'dart:async';

// Package imports:
import 'package:image_picker/image_picker.dart';
import 'package:pdf_collage/domain/repositories/pick_image_repository.dart';

class DevicePickImagesRepository implements PickImageRepository {
  final ImagePicker picker = ImagePicker();

  @override
  Future<List<XFile>> pickMultipleImages() async {
    try {
      final res = await picker.pickMultiImage(imageQuality: 30);
      return res ?? [];
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<XFile?> pickOneImage() async {
    return picker.pickImage(source: ImageSource.gallery);
  }
}
