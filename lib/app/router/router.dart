// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf_collage/app/pages/details_screen.dart';
import 'package:pdf_collage/app/pages/home_screen.dart';
import 'package:pdf_collage/app/providers/providers.dart';
import 'package:pdf_collage/domain/blocs/files/files_bloc.dart';
import 'package:pdf_collage/domain/blocs/images/image_bloc.dart';

class RouterImpl {
  static GoRouter router() {
    return GoRouter(initialLocation: '${Routes.home}/0', debugLogDiagnostics: true, routes: [
      GoRoute(
          path: '${Routes.home}/:hid',
          builder: (context, state) {
            final hid = int.tryParse(state.params['hid']!) ?? 0;

            return BlocProvider(
              create: (_) => getIt<FilesBloc>()..add(const FilesRequested()),
              child: BlocProvider(
                create: (_) => getIt<ImageBloc>(),
                child: HomePage(key: state.pageKey, currentTab: hid),
              ),
            );
          },
          routes: [
            GoRoute(
              path: Routes.details,
              builder: (context, state) => DetailsScreen(
                file: state.extra as File,
              ),
            ),
          ]),
    ]);
  }
}

class Routes {
  static const details = 'details';
  static const home = '/home';
}
