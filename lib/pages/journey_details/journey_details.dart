import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jorney/pages/home/home.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/styles.dart';
import '../../models/journey.dart';
import '../../widgets/close_btn.dart';

class JourneyDetails extends StatelessWidget {
  const JourneyDetails({super.key, required this.journey});
  final Journey journey;

  static Route route(Journey journey) => PageRouteBuilder(
        fullscreenDialog: true,
        pageBuilder: (context, animation, secondaryAnimation) {
          return JourneyDetails(journey: journey);
        },
      );

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
              backgroundColor: colors.primaryBg,
              border: null,
              leading: const CloseBtn(),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 16),
                child: Text(
                  'Day ${journey.progress}',
                  style: styles.body.copyWith(color: colors.accent),
                ),
              ),
              padding: const EdgeInsetsDirectional.only(),
              largeTitle: Text(
                '${journey.title}',
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
                ActionCard(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white10,
                    child: Icon(
                      CupertinoIcons.camera_circle_fill,
                      size: 30,
                      color: colors.primaryTextColor,
                    ),
                  ),
                  title: 'Upload Progress',
                  subtitle:
                      'Upload Image and details about your progress for the ${journey.journeyType.toString()}',
                  onPressed: () {},
                ),
                Expanded(
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(),
                    crossAxisCount: 5,
                    childAspectRatio: 1,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: List.generate(
                      journey.progress!,
                      (index) => Container(
                        decoration: BoxDecoration(
                          color: colors.primaryCard,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              journey.journeyType.toString(),
                              style: const TextStyle(color: Colors.white54),
                            ),
                            Text((index + 1).toString(), style: styles.title)
                          ],
                        ),
                      ),
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
