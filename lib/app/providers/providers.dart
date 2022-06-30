// Package imports:
import 'package:get_it/get_it.dart';
import 'package:pdf_collage/data/repositories/data_pdf_repository.dart';
import 'package:pdf_collage/device/repositories/device_pick_images_repository.dart';
import 'package:pdf_collage/domain/blocs/files/files_bloc.dart';
import 'package:pdf_collage/domain/blocs/images/image_bloc.dart';
import 'package:pdf_collage/domain/blocs/save_pdf/save_pdf_cubit.dart';

final getIt = GetIt.I;

Future<void> resolveDependencies() async {
  ///services
  getIt
    ..registerSingleton<DataPdfRepository>(DataPdfRepository())
    ..registerSingleton<DevicePickImagesRepository>(DevicePickImagesRepository());

  ///blocs
  getIt
    ..registerSingleton<FilesBloc>(FilesBloc(getIt<DataPdfRepository>()))
    ..registerSingleton<ImageBloc>(ImageBloc(getIt<DevicePickImagesRepository>()))
    ..registerSingleton<SavePdfCubit>(SavePdfCubit(
      getIt<DataPdfRepository>(),
      getIt<FilesBloc>(),
      getIt<ImageBloc>(),
    ));
}
