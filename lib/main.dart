// Dart imports:

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:pdf_collage/app.dart';
import 'package:pdf_collage/app/providers/providers.dart';

Future<void> main() async {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await resolveDependencies();

      runApp(const App());
    },
  );
}
