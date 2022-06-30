// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:pdf_collage/device/repositories/device_pick_images_repository.dart';

part 'image_event.dart';
part 'image_state.dart';

class ImageBloc extends Bloc<ImageEvent, ImagesState> {
  final DevicePickImagesRepository devicePickImagesRepository;

  ImageBloc(this.devicePickImagesRepository) : super(const ImagesState()) {
    on<OnSelectMultipleImageEvent>((_onSelectMultipleImages));
    on<OnReorderImagesEvent>((_onReorderImages));
    on<OnPdfCreatedEvent>((_onPdfCreated));
  }
  Future<void> _onPdfCreated(OnPdfCreatedEvent event, Emitter<ImagesState> emit) async {
    emit(
      state.copyWith(
        status: FutureStatus.initial,
        images: [],
      ),
    );
  }

  Future<void> _onReorderImages(OnReorderImagesEvent event, Emitter<ImagesState> emit) async {
    List<XFile> newList = List.from(state.images);
    final image = newList.removeAt(event.oldIndex);
    newList.insert(event.newIndex, image);
    emit(
      state.copyWith(
        status: FutureStatus.success,
        images: newList,
      ),
    );
  }

  Future<void> _onSelectMultipleImages(OnSelectMultipleImageEvent event, Emitter<ImagesState> emit) async {
    try {
      emit(state.copyWith(
        status: FutureStatus.loading,
      ));
      if (state.status == FutureStatus.initial) {
        final images = await devicePickImagesRepository.pickMultipleImages();
        return emit(state.copyWith(
          status: FutureStatus.success,
          images: images,
        ));
      }
      final images = await devicePickImagesRepository.pickMultipleImages();
      emit(
        state.copyWith(
          status: FutureStatus.success,
          images: List.from(state.images)..addAll(images),
        ),
      );
    } on Exception {
      emit(state.copyWith(
        status: FutureStatus.failure,
      ));
    }
  }
}
