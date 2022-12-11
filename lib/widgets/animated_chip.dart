import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/styles.dart';

class FloatingChip extends StatefulWidget {
  const FloatingChip({
    Key? key,
    required this.e,
  }) : super(key: key);
  final MapEntry<String, Icon> e;

  @override
  State<FloatingChip> createState() => _FloatingChipState();
}

class _FloatingChipState extends State<FloatingChip>
    with TickerProviderStateMixin {
  late AnimationController wobbleController;
  late Animation wobbleAnim;
  late AnimationController floatAnimationController;
  late Animation floatAnimationDy;

  @override
  void initState() {
    super.initState();
    wobbleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 550));
    wobbleAnim = Tween(begin: 0.0, end: 0.0223599).animate(wobbleController);
    floatAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1050));
    floatAnimationDy =
        Tween(begin: 0.8, end: -0.8).animate(floatAnimationController);
    floatAnimationController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    wobbleController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
    floatAnimationController.repeat(reverse: true);
    wobbleController.repeat(reverse: true);
  }

  @override
  void dispose() {
    wobbleController.dispose();
    floatAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors();
    final TextStyles styles = TextStyles();
    return Transform.translate(
      offset: Offset(0, floatAnimationDy.value),
      child: Transform.rotate(
        angle: wobbleAnim.value,
        child: Padding(
          padding: const EdgeInsets.only(right: 24, bottom: 24),
          child: Chip(
            backgroundColor: colors.primaryCard,
            padding: const EdgeInsets.only(
              left: 16,
              right: 24,
              top: 16,
              bottom: 16,
            ),
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.e.value,
                const SizedBox(width: 12),
                Text(widget.e.key, style: styles.body),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
