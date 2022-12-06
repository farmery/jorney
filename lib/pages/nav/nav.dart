import 'package:flutter/cupertino.dart';
import 'package:jorney/pages/history/history.dart';
import 'package:jorney/pages/home/home.dart';
import 'package:jorney/utils/colors.dart';

class Nav extends StatefulWidget {
  const Nav({super.key});

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    List pages = const [
      Home(),
      History(),
      History(),
    ];
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
              icon: Icon(CupertinoIcons.settings), label: 'Settings'),
        ],
      ),
      tabBuilder: (context, index) {
        return pages[index];
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
