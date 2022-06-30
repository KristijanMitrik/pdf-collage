// Dart imports:
import 'dart:async';
import 'dart:io';

// Package imports:
import 'package:image_picker/image_picker.dart';
import 'package:pdf/widgets.dart' as pw;

/// Handles operations related to pdf.
abstract class PdfRepository {
  /// Returns the [Pdf] file created from the picked image [File]'s.
  Future<pw.Document> createPdf(List<XFile> images);

  /// Saves the [Pdf] in [Storage].
  Future<File> savePdf(pw.Document pdf);
  Future<Stream<FileSystemEntity>> getFiles();
}
