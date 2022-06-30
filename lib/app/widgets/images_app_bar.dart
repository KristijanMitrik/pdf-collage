// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:pdf_collage/domain/blocs/images/image_bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final imageBloc = BlocProvider.of<ImageBloc>(context, listen: false);

    return AppBar(
      centerTitle: false,
      title: const Text('Create Collage'),
      actions: [addImages(imageBloc)],
    );
  }
}

extension AddImages on CustomAppBar {
  Widget addImages(ImageBloc imageBloc) {
    return IconButton(
      icon: const Icon(
        Icons.add_a_photo,
        size: 30,
        color: Colors.white,
      ),
      onPressed: () => imageBloc.add(
        OnSelectMultipleImageEvent(),
      ),
    );
  }
}
