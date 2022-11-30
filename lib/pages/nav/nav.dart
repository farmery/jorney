import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/pages/home/home.dart';
import 'package:jorney/pages/nav/nav_vm.dart';
import 'package:jorney/utils/colors.dart';

class Nav extends ConsumerWidget {
  const Nav({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors();
    return CupertinoTabScaffold(
      backgroundColor: colors.primaryBg,
      tabBar: CupertinoTabBar(
        iconSize: 20,
        backgroundColor: colors.secondaryBg,
        activeColor: colors.accent,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.time), label: 'History'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_alt_circle), label: 'Profile'),
        ],
      ),
      tabBuilder: (context, index) {
        return const Home();
      },
    );
  }
}
