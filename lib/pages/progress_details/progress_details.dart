import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jorney/utils/colors.dart';

import '../../models/journey.dart';
import '../../models/progress.dart';
import '../../widgets/close_btn.dart';

class ProgressDetails extends StatelessWidget {
  const ProgressDetails({
    super.key,
    required this.progress,
    required this.journeyType,
  });
  final Progress progress;
  final JourneyType journeyType;
  static Route route(Progress progress, JourneyType journeyType) =>
      CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (context) {
          return ProgressDetails(progress: progress, journeyType: journeyType);
        },
      );

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        backgroundColor: colors.primaryBg,
        border: null,
        leading: const CloseBtn(),
        trailing: progress.tracked
            ? CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(Icons.more_horiz_rounded),
                onPressed: () {},
              )
            : null,
        middle: Text(
          '${journeyType.toString()} ${progress.progressNo}',
          style: const TextStyle(color: Colors.white),
        ),
        padding: const EdgeInsetsDirectional.only(),
      ),
      child: Container(
        color: colors.primaryBg,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        child: progress.tracked
            ? Column(
                children: [
                  Expanded(child: Image(image: NetworkImage(progress.imgUrl!))),
                ],
              )
            : const ImageUploadOptionsView(),
      ),
    );
  }
}

class ImageUploadOptionsView extends StatelessWidget {
  const ImageUploadOptionsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppColors colors = AppColors();
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colors.secondaryBg,
            ),
            child: Icon(
              CupertinoIcons.camera_fill,
              size: 35,
              color: colors.accent,
            ),
          ),
        ),
        const Divider(indent: 16, endIndent: 16, height: 100),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {},
          child: Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: colors.secondaryBg,
            ),
            child: Icon(
              CupertinoIcons.photo_on_rectangle,
              size: 35,
              color: colors.accent,
            ),
          ),
        ),
      ],
    );
  }
}
