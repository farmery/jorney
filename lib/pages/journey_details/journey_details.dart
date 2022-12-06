import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/pages/journey_details/journey_details_vm.dart';
import 'package:jorney/pages/progress_details/progress_details.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/styles.dart';
import '../../models/journey.dart';
import '../../widgets/close_btn.dart';

class JourneyDetails extends ConsumerStatefulWidget {
  const JourneyDetails({super.key, required this.journey});
  final Journey journey;

  static Route route(Journey journey) => CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return JourneyDetails(journey: journey);
        },
      );

  @override
  ConsumerState<JourneyDetails> createState() => _JourneyDetailsState();
}

class _JourneyDetailsState extends ConsumerState<JourneyDetails> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(progressVm.notifier).getProgress(widget.journey.journeyId!);
    });
  }

  @override
  Widget build(BuildContext context) {
    final progressList = ref.watch(progressVm);
    final colors = AppColors();
    final styles = TextStyles();
    return CupertinoPageScaffold(
      backgroundColor: colors.primaryBg,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              backgroundColor: colors.primaryBg,
              border: null,
              leading: const CloseBtn(),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  '${widget.journey.journeyType.toString()} ${widget.journey.level}',
                  style: styles.body.copyWith(color: colors.accent),
                ),
              ),
              padding: const EdgeInsetsDirectional.only(),
              largeTitle: Text(
                '${widget.journey.title}',
                style: TextStyle(color: colors.primaryTextColor),
              ),
            )
          ];
        },
        body: Scaffold(
          backgroundColor: colors.primaryBg,
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: colors.accent.withOpacity(0.1),
                  ),
                ),
                if (progressList != null)
                  Expanded(
                    child: GridView.count(
                      padding: const EdgeInsets.only(top: 24),
                      physics: const BouncingScrollPhysics(),
                      crossAxisCount: 5,
                      childAspectRatio: 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: List.generate(
                        progressList.length,
                        (index) {
                          final progress = progressList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                ProgressDetails.route(
                                  progress,
                                  widget.journey.journeyType,
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: progress.tracked
                                    ? colors.primaryCard
                                    : colors.greyDark,
                                borderRadius: BorderRadius.circular(10),
                                border: progress.tracked
                                    ? null
                                    : Border.all(color: colors.accent),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.journey.journeyType.toString(),
                                    style:
                                        const TextStyle(color: Colors.white54),
                                  ),
                                  Text(
                                    (progressList[index].progressNo).toString(),
                                    style: styles.title,
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
