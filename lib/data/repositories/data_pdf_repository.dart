// Dart imports:
import 'dart:io';

// Package imports:
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// Project imports:
import 'package:pdf_collage/data/helpers/helpers.dart';
import 'package:pdf_collage/domain/repositories/pdf_repository.dart';

class DataPdfRepository implements PdfRepository {
  @override
  Future<pw.Document> createPdf(List<XFile> images) async {
    var pdf = pw.Document();

    final files = await getImagesBytes(images);
    final List<pw.Widget> pdfImages = files.map((image) {
      return pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child:
              pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.center, mainAxisSize: pw.MainAxisSize.max, children: [
            pw.Image(
                pw.MemoryImage(
                  image,
                ),
                fit: pw.BoxFit.cover,
                width: 200,
                height: 200)
          ]));
    }).toList();

    pdf.addPage(pw.MultiPage(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.GridView(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: pdfImages,
            ),
          ];
        }));
    return pdf;
  }

  @override
  Future<File> savePdf(pw.Document pdf) async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    String documentPath = documentDirectory.path;

    String id = DateTime.now().toString();

    File file = File("$documentPath/$id.pdf");

    return file.writeAsBytes(await pdf.save());
  }

  @override
  Future<Stream<FileSystemEntity>> getFiles() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();

    return documentDirectory.list(recursive: false);
  }
}
