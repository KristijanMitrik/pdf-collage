// Dart imports:
import 'dart:io';

// Package imports:
import 'package:badges/badges.dart';
import 'package:collection/collection.dart';
// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pdf_collage/app/dialogs/confirm_file_creation.dart';
import 'package:pdf_collage/app/widgets/images_app_bar.dart';
import 'package:pdf_collage/domain/blocs/images/image_bloc.dart';
import 'package:reorderables/reorderables.dart';

class ImagesScreen extends StatelessWidget {
  const ImagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showConfirmFileCreationDialog(context: context);
        },
        child: const Icon(
          Icons.download_sharp,
          size: 30,
          color: Colors.white,
        ),
      ),
      body: BlocBuilder<ImageBloc, ImagesState>(builder: (context, state) {
        switch (state.status) {
          case FutureStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case FutureStatus.failure:
            return const Center(child: Text('Error occured. Please try again'));
          case FutureStatus.initial:
            return const Center(
              child: Text('No Photos selected'),
            );
          case FutureStatus.success:
            return ReorderableWrap(
              controller: ScrollController(),
              needsLongPressDraggable: false,
              spacing: 10,
              runSpacing: 10.0,
              maxMainAxisCount: 3,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              onReorder: (oldIndex, newIndex) =>
                  context.read<ImageBloc>().add(OnReorderImagesEvent(oldIndex: oldIndex, newIndex: newIndex)),
              children: state.images
                  .mapIndexed((index, e) => Badge(
                        position: BadgePosition.topStart(top: -10, start: -10),
                        shape: BadgeShape.circle,
                        badgeColor: Colors.blueGrey,
                        toAnimate: false,
                        badgeContent: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            (index + 1).toString(),
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        elevation: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.5,
                          height: MediaQuery.of(context).size.width / 3.5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(e.path)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            );
          default:
            return const Center(
              child: CircularProgressIndicator(),
            );
        }
      }),
    );
  }
}
