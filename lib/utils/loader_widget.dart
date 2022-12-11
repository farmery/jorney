import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'colors.dart';
import 'loader_vm.dart';

class LoaderWidget extends ConsumerWidget {
  const LoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vm = ref.watch(loaderVm);
    final colors = AppColors();
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: vm.isLoading
          ? Container(
              color: Colors.black.withOpacity(0.6),
              child: Center(
                child: CupertinoActivityIndicator(
                  color: colors.accent,
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
