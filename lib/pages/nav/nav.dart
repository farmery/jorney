import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/pages/auth/auth_view.dart';
import 'package:jorney/pages/history/history.dart';
import 'package:jorney/pages/home/home.dart';
import 'package:jorney/pages/settings/settings.dart';
import 'package:jorney/utils/colors.dart';

import '../../services/auth_service.dart';

class Nav extends ConsumerStatefulWidget {
  const Nav({super.key});

  @override
  ConsumerState<Nav> createState() => _NavState();
}

class _NavState extends ConsumerState<Nav> with AutomaticKeepAliveClientMixin {
  List pages = const [
    Home(),
    History(),
    Settings(),
  ];
  @override
  Widget build(BuildContext context) {
    final userAuthStream = ref.watch(authStateChanges);
    final colors = AppColors();
    super.build(context);
    return userAuthStream.when(
      data: (user) {
        if (user == null) {
          return const AuthView();
        }
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
                  icon: Icon(CupertinoIcons.settings), label: 'Settings'),
            ],
          ),
          tabBuilder: (context, index) {
            return pages[index];
          },
        );
      },
      error: (error, stackTrace) {
        return const SizedBox();
      },
      loading: () {
        return const CircularProgressIndicator();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
