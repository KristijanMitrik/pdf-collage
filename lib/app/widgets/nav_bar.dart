// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:pdf_collage/app/router/router.dart';

class HomeNavBar extends StatelessWidget {
  const HomeNavBar({required this.currentTab, Key? key}) : super(key: key);

  final int currentTab;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedLabelStyle: const TextStyle(fontSize: 12),
      unselectedLabelStyle: const TextStyle(fontSize: 10),
      type: BottomNavigationBarType.fixed,
      currentIndex: currentTab,
      items: [
        BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle_rounded, size: currentTab == 0 ? 28 : 24), label: "Create"),
        BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined, size: currentTab == 1 ? 28 : 24), label: "My Files"),
      ],
      elevation: 15,
      onTap: (index) => context.go('${Routes.home}/$index'),
    );
  }
}
