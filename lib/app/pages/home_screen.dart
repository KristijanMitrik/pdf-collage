// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:pdf_collage/app/pages/files_screen.dart';
import 'package:pdf_collage/app/pages/images_screen.dart';
import 'package:pdf_collage/app/widgets/nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key, required this.currentTab}) : super(key: key);

  final int currentTab;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: HomeNavBar(
        currentTab: currentTab,
      ),
      body: IndexedStack(
        index: currentTab,
        children: const [
          ImagesScreen(),
          FilesScreen(),
        ],
      ),
    );
  }
}
