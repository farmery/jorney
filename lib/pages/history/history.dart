import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jorney/models/journey.dart';
import 'package:jorney/pages/journey_details/journey_details.dart';
import 'package:jorney/pages/new_journey/new_jourmey.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/device_dimens.dart';
import 'package:jorney/utils/styles.dart';

class History extends ConsumerStatefulWidget {
  const History({super.key});

  @override
  ConsumerState<History> createState() => _HistoryState();
}

class _HistoryState extends ConsumerState<History> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    final styles = TextStyles();
    return CupertinoPageScaffold(
      backgroundColor: colors.primaryBg,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              backgroundColor: colors.primaryBg.withOpacity(0.5),
              largeTitle: const Text(
                'History',
                style: TextStyle(color: Colors.white),
              ),
            )
          ];
        },
        body: Scaffold(
          backgroundColor: colors.primaryBg,
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [],
          ),
        ),
      ),
    );
  }
}
