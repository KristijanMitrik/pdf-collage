// Package imports:
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:pdf_collage/data/repositories/data_pdf_repository.dart';
import 'package:pdf_collage/domain/blocs/files/files_bloc.dart';
import 'package:pdf_collage/domain/blocs/images/image_bloc.dart';

part 'save_pdf_state.dart';

class SavePdfCubit extends Cubit<SavePdfState> {
  final DataPdfRepository pdfRepository;
  SavePdfCubit(this.pdfRepository) : super(SavePdfInitial());

  Future<void> savePdf(List<XFile> images, ImageBloc imagebloc, FilesBloc filesBloc) async {
    try {
      emit(SavePdfLodinng());
      final res = await pdfRepository.createPdf(images);
      final file = await pdfRepository.savePdf(res);
      emit(SavePdfSuccess());
      filesBloc.add(NewFile(file));
      imagebloc.add(OnPdfCreatedEvent());
    } catch (e) {
      emit(const SavePdfFail('Saving pdf failed'));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
