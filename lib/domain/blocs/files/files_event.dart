part of 'files_bloc.dart';

abstract class FilesEvent extends Equatable {
  /// {@macro ticker_event}
  const FilesEvent();

  @override
  List<Object> get props => [];
}

class FilesRequested extends FilesEvent {
  const FilesRequested();
}

class NewFile extends FilesEvent {
  const NewFile(this.file);

  /// The current tick count.
  final File file;

  @override
  List<Object> get props => [file];
}
