// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:styled_widget/styled_widget.dart';

// Project imports:
import 'package:pdf_collage/app/providers/providers.dart';
import 'package:pdf_collage/app/widgets/easy_text.dart';
import 'package:pdf_collage/domain/blocs/files/files_bloc.dart';
import 'package:pdf_collage/domain/blocs/images/image_bloc.dart';
import 'package:pdf_collage/domain/blocs/save_pdf/save_pdf_cubit.dart';

void showConfirmFileCreationDialog({required BuildContext context}) {
  showDialog(
    context: context,
    useSafeArea: true,
    barrierDismissible: true,
    builder: (ctx) {
      return Dialog(
        shape: Border.all(style: BorderStyle.none),
        child: _ConfirmFileCreationView(
          ctx: context,
        ),
      );
    },
  );
}

class _ConfirmFileCreationView extends StatelessWidget {
  const _ConfirmFileCreationView({Key? key, required this.ctx}) : super(key: key);

  final BuildContext ctx;
  @override
  Widget build(BuildContext context) {
    final images = ctx.read<ImageBloc>().state.images;

    return BlocProvider(
      create: (_) => getIt<SavePdfCubit>(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<SavePdfCubit, SavePdfState>(builder: (context, state) {
          if (state is SavePdfLodinng) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SavePdfSuccess) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const EasyText('File has been created successfully.').padding(bottom: 20),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const EasyText('Go Back'))
              ],
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: images.isEmpty
                ? [
                    const EasyText(
                      'No Images has been selected.',
                      color: Colors.red,
                    ).padding(bottom: 20),
                    TextButton(
                      child: const EasyText('Select images'),
                      onPressed: () {
                        Navigator.pop(context);
                        ctx.read<ImageBloc>().add(
                              OnSelectMultipleImageEvent(),
                            );
                      },
                    )
                  ]
                : [
                    EasyText(
                      'Do you want to create a collage with ${images.length} images ?',
                      color: Colors.blueGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      maxLines: 5,
                      textAlign: TextAlign.center,
                    ).padding(bottom: 20),
                    if (state is SavePdfFail)
                      const EasyText(
                        'Failed to save the file. Please try again',
                        color: Colors.redAccent,
                      ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          child: const EasyText('Select more images'),
                          onPressed: () {
                            Navigator.pop(context);
                            ctx.read<ImageBloc>().add(
                                  OnSelectMultipleImageEvent(),
                                );
                          },
                        ),
                        TextButton(
                          child: const EasyText(
                            'Create',
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            context.read<SavePdfCubit>().savePdf(images, ctx.read<ImageBloc>(), ctx.read<FilesBloc>());
                          },
                        ),
                      ],
                    )
                  ],
          );
        }),
      ),
    );
  }
}
