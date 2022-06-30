// Dart imports:
import 'dart:io';

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Project imports:
import 'package:pdf_collage/data/repositories/data_pdf_repository.dart';
import 'package:pdf_collage/domain/blocs/images/image_bloc.dart';

part 'files_event.dart';
part 'files_state.dart';

class FilesBloc extends Bloc<FilesEvent, FilesState> {
  final DataPdfRepository repository;
  FilesBloc(this.repository) : super(const FilesState()) {
    on<FilesRequested>(
      (event, emit) async {
        try {
          await emit.onEach<FileSystemEntity>(
            await repository.getFiles(),
            onData: (file) {
              if (file is File) {
                add(NewFile(file));
              }
            },
          );
        } on Exception {
          emit(state.copyWith(
            status: FutureStatus.failure,
          ));
        }
      },
    );

    on<NewFile>((event, emit) => emit(FilesState(
          status: FutureStatus.success,
          files: List.from(state.files)..add(event.file),
        )));
  }
}
