// Dart imports:
import 'dart:async';

// Package imports:
import 'package:image_picker/image_picker.dart';

/// Handles operations related to picking images services.
abstract class PickImageRepository {
  /// Returns the [XFile]'s picked from [Storage].
  Future<List<XFile>> pickMultipleImages();

  /// Returns an [XFile] picked from [Storage].
  Future<XFile?> pickOneImage();
}
