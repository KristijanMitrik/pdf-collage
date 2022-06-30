// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:pdf_collage/app/widgets/easy_text.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DetailsScreen extends StatelessWidget {
  final File file;

  const DetailsScreen({Key? key, required this.file}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const EasyText('Details'),
      ),
      body: SfPdfViewer.file(File(file.path)),
    );
  }
}
