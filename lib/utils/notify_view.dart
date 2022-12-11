import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/notify_vm.dart';
import 'package:jorney/utils/styles.dart';

class NotifyView extends ConsumerWidget {
  const NotifyView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(notifyVm);
    final styles = TextStyles();
    final colors = AppColors();
    return AnimatedPositioned(
      curve: Curves.easeInBack,
      duration: const Duration(milliseconds: 1000),
      left: 16,
      right: 16,
      top: vm.isShowing ? 110 : -140,
      child: Material(
        color: colors.primaryCard,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 10,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(vm.msg, style: styles.body),
          ),
        ),
      ),
    );
  }
}
