import 'package:flutter/cupertino.dart';
import '../utils/colors.dart';

class CloseBtn extends StatelessWidget {
  const CloseBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.pop(context);
      },
      child: Icon(
        CupertinoIcons.clear,
        size: 20,
        color: colors.primaryTextColor,
      ),
    );
  }
}
