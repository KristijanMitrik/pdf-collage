part of 'save_pdf_cubit.dart';


abstract class SavePdfState extends Equatable {
  const SavePdfState();

  @override
  List<Object> get props => [];
}

class SavePdfInitial extends SavePdfState {}

class SavePdfLodinng extends SavePdfState {}

class SavePdfSuccess extends SavePdfState {}

class SavePdfFail extends SavePdfState {
  final String error;

  const SavePdfFail(this.error);
  @override
  List<Object> get props => [error];
}
