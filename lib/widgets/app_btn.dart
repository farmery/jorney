import 'package:flutter/cupertino.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class AppBtn extends StatelessWidget {
  const AppBtn({
    Key? key,
    this.onPressed,
    required this.text,
    this.enabled = true,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final String text;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors();
    final TextStyles styles = TextStyles();
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: enabled ? onPressed : null,
      child: Opacity(
        opacity: enabled ? 1 : 0.4,
        child: Container(
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: colors.accent,
          ),
          child: Text(text, style: styles.body),
        ),
      ),
    );
  }
}
