import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jorney/models/journey.dart';
import 'package:jorney/pages/journey_details/journey_details.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/device_dimens.dart';
import 'package:jorney/utils/styles.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
                'Home',
                style: TextStyle(color: Colors.white),
              ),
            )
          ];
        },
        body: Scaffold(
          backgroundColor: colors.primaryBg,
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ActionCard(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white10,
                  child: SvgPicture.asset('assets/icons/rocket.svg'),
                ),
                title: 'New Journey',
                subtitle:
                    'At the end of your journey you can export your progress as a timelapse ',
                onPressed: () {},
              ),
              const SizedBox(height: 16),
              Text('Ongoing Journeys', style: styles.subtitle1),
              const SizedBox(height: 16),
              CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: () {
                  Navigator.push(
                    context,
                    JourneyDetails.route(
                      Journey(
                        progress: 20,
                        title: 'Weight Loss',
                        journeyType: JourneyType.daily,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colors.secondaryBg,
                  ),
                  child: Row(
                    children: [
                      CupertinoButton(
                        onPressed: () {},
                        padding: EdgeInsets.zero,
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white10,
                          child: Icon(
                            CupertinoIcons.play_circle_fill,
                            color: colors.primaryTextColor,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SizedBox(
                          width: deviceWidth(context) * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Weight Loss Journey',
                                  style: styles.subtitle2),
                              const SizedBox(height: 4),
                              Text(
                                'Day 20',
                                style: styles.title.copyWith(fontSize: 24),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Icon(
                        CupertinoIcons.chevron_forward,
                        color: colors.greyLight,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ActionCard extends StatelessWidget {
  const ActionCard({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.subtitle,
    this.leading,
  }) : super(key: key);
  final VoidCallback onPressed;
  final String title;
  final String subtitle;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    final styles = TextStyles();
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors.primaryCard,
        ),
        child: Row(
          children: [
            if (leading != null) leading!,
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: styles.title),
                const SizedBox(height: 4),
                SizedBox(
                  width: deviceWidth(context) * 0.6,
                  child: Text(
                    subtitle,
                    style: styles.subtitle2,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
