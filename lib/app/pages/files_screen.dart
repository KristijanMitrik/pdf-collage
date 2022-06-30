// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:pdf_collage/app/widgets/file_item.dart';
import 'package:pdf_collage/domain/blocs/files/files_bloc.dart';
import 'package:pdf_collage/domain/blocs/images/image_bloc.dart';

class FilesScreen extends HookWidget {
  const FilesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('My Files'),
      ),
      body: BlocBuilder<FilesBloc, FilesState>(builder: (context, state) {
        final sortedFiles = List<File>.from(state.files)..sort(((a, b) => b.path.compareTo(a.path)));
        switch (state.status) {
          case FutureStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FutureStatus.failure:
            return const Center(child: Text('Error occured. Please try again'));
          case FutureStatus.initial:
            return const Center(
              child: Text('No Files'),
            );
          case FutureStatus.success:
            return ListView.builder(
                shrinkWrap: true,
                itemCount: sortedFiles.length,
                itemBuilder: (ctx, i) => FileItem(
                      file: sortedFiles[i],
                      index: i + 1,
                    ));
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      }),
    );
  }
}
