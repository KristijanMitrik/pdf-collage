part of 'files_bloc.dart';

class FilesState extends Equatable {
  const FilesState({
    this.status = FutureStatus.initial,
    this.files = const <File>[],
  });

  final FutureStatus status;
  final List<FileSystemEntity> files;

  FilesState copyWith({
    FutureStatus? status,
    List<File>? files,
  }) {
    return FilesState(
      status: status ?? this.status,
      files: files ?? this.files,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status,  images: ${files.length} }''';
  }

  @override
  List<Object> get props => [
        status,
        files,
      ];
}
