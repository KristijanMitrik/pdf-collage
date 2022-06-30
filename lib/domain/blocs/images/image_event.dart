part of 'image_bloc.dart';

@immutable
abstract class ImageEvent {}

class OnSelectMultipleImageEvent extends ImageEvent {
  OnSelectMultipleImageEvent();
}

class OnReorderImagesEvent extends ImageEvent {
  final int oldIndex, newIndex;
  OnReorderImagesEvent({required this.newIndex, required this.oldIndex});
}

class OnPdfCreatedEvent extends ImageEvent {
  OnPdfCreatedEvent();
}
