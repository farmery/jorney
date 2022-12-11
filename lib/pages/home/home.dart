import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jorney/models/journey.dart';
import 'package:jorney/pages/home/home_vm.dart';
import 'package:jorney/pages/journey_details/journey_details.dart';
import 'package:jorney/pages/new_journey/new_journey.dart';
import 'package:jorney/services/auth_service.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/device_dimens.dart';
import 'package:jorney/utils/styles.dart';
import 'package:lottie/lottie.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeVm.notifier).getJourneys('userId');
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authStateChanges).value!;
    final journeys = ref.watch(homeVm);
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
                onPressed: () async {
                  final journeyIsCreated =
                      await Navigator.push(context, NewJourney.route());
                  if (journeyIsCreated == true) {
                    ref.read(homeVm.notifier).getJourneys(user.userId!);
                  }
                },
              ),
              const SizedBox(height: 16),
              if (journeys == null)
                const SizedBox()
              else if (journeys.isNotEmpty) ...[
                Text('Ongoing Journeys', style: styles.subtitle1),
                ...List.generate(
                  journeys.length,
                  (index) => JourneyItemView(journey: journeys[index]),
                )
              ] else if (journeys.isEmpty) ...[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: LottieBuilder.asset('assets/icons/empty.json'),
                ),
                Center(
                  child: Text(
                    'You currently dont have any active journeys',
                    style: styles.body,
                  ),
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class JourneyItemView extends StatelessWidget {
  const JourneyItemView({
    Key? key,
    required this.journey,
  }) : super(key: key);
  final Journey journey;

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors();
    final TextStyles styles = TextStyles();
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.push(
          context,
          JourneyDetails.route(journey),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors.secondaryBg,
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.white10,
              child: Icon(Icons.ac_unit_outlined),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SizedBox(
                width: deviceWidth(context) * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(journey.title ?? '--', style: styles.body),
                    const SizedBox(height: 4),
                    Text(
                      '${journey.journeyType.toString()} ${journey.level}',
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
