import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/styles.dart';
import '../../models/journey.dart';
import '../../widgets/close_btn.dart';

class NewJourney extends ConsumerStatefulWidget {
  const NewJourney({super.key});
  static Route route() => CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => const NewJourney(),
      );
  @override
  ConsumerState<NewJourney> createState() => _NewJourneyState();
}

class _NewJourneyState extends ConsumerState<NewJourney> {
  @override
  Widget build(BuildContext context) {
    List<String> journeyTypes = [
      JourneyType.daily.name,
      JourneyType.weekly.name,
      JourneyType.monthly.name,
    ];
    final colors = AppColors();
    final styles = TextStyles();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: CupertinoPageScaffold(
        backgroundColor: colors.primaryBg,
        navigationBar: CupertinoNavigationBar(
          middle: const Text(
            'New Journey',
            style: TextStyle(color: Colors.white),
          ),
          padding: const EdgeInsetsDirectional.only(),
          backgroundColor: colors.primaryBg,
          leading: const CloseBtn(),
        ),
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: colors.primaryBg,
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colors.secondaryBg,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colors.secondaryBg,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colors.secondaryBg,
                          ),
                        ),
                        labelText: 'Journey Title',
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Progress Track Interval', style: styles.body),
                    const SizedBox(height: 4),
                    Text(
                      'How frequent do you want to track progress on your journey',
                      style: styles.subtitle2,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        journeyTypes.length,
                        (index) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(right: 16),
                            alignment: Alignment.center,
                            height: 40,
                            decoration: BoxDecoration(
                              color: colors.primaryCard,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                                Text(journeyTypes[index], style: styles.body),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16,
              child: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.accent,
                  ),
                  child: Text('Start Journey', style: styles.body),
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
