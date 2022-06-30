part of 'image_bloc.dart';

enum FutureStatus { initial, success, failure, loading }

class ImagesState extends Equatable {
  const ImagesState({
    this.status = FutureStatus.initial,
    this.images = const <XFile>[],
  });

  final FutureStatus status;
  final List<XFile> images;

  ImagesState copyWith({
    FutureStatus? status,
    List<XFile>? images,
  }) {
    return ImagesState(
      status: status ?? this.status,
      images: images ?? this.images,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status,  images: ${images.length} }''';
  }

  @override
  List<Object> get props => [
        status,
        images,
      ];
}
