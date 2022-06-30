// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:pdf_collage/app/router/router.dart';

class App extends HookWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = useMemoized(() => RouterImpl.router());
    return MaterialApp.router(
        routeInformationProvider: router.routeInformationProvider,
        routeInformationParser: router.routeInformationParser,
        routerDelegate: router.routerDelegate,
        title: 'PDF Collage',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ));
  }
}
