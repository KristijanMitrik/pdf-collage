// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';
import 'package:pdf_collage/app/widgets/easy_text.dart';
import 'package:pdf_collage/device/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:styled_widget/styled_widget.dart';

class FileItem extends HookWidget {
  final int index;
  final File file;

  const FileItem({Key? key, required this.file, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade200,
      child: ListTile(
        title: EasyText(
          'My Collage $index',
          fontSize: 18,
          fontWeight: FontWeight.w700,
          maxLines: 2,
        ),
        subtitle: EasyText(
          formatDate(basename(file.path.split('.').first)),
          fontWeight: FontWeight.w700,
          maxLines: 2,
        ),
        trailing: Wrap(children: [
          InkWell(
            onTap: () {
              context.go('/home/1/details/', extra: file);
            },
            child: const Icon(
              Icons.open_in_new_outlined,
              color: Colors.black,
            ),
          ).padding(left: 10, right: 20),
          Builder(builder: (context) {
            return InkWell(
              onTap: () {
                _onShare(context, file.path, index);
              },
              child: const Icon(
                Icons.share,
                color: Colors.black,
              ),
            ).padding(right: 10);
          })
        ]),
      ),
    ).padding(horizontal: 10, vertical: 4);
  }

  void _onShare(BuildContext context, String path, int index) async {
    final box = context.findRenderObject() as RenderBox?;

    await Share.shareFiles(
      [path],
      text: 'My Collage $index',
      subject: 'My Collage $index',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }
}
