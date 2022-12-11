import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jorney/pages/progress_details/progress_detail_vm.dart';
import 'package:jorney/utils/colors.dart';
import '../../models/journey.dart';
import '../../models/progress.dart';
import '../../widgets/app_btn.dart';
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

class ImageUploadOptionsView extends ConsumerWidget {
  const ImageUploadOptionsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppColors colors = AppColors();
    final vm = ref.watch(progressDetailVm.notifier);
    final selectedImage = ref.watch(progressDetailVm);
    return Scaffold(
      backgroundColor: colors.primaryBg,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (selectedImage != null) ...[
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: MemoryImage(selectedImage.readAsBytesSync()),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.greyLight),
                  ),
                  child: CupertinoButton(
                    child: const Icon(CupertinoIcons.camera_fill),
                    onPressed: () {
                      pickImage(vm, ImageSource.camera);
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: colors.greyLight),
                  ),
                  child: CupertinoButton(
                    child: const Icon(CupertinoIcons.photo_on_rectangle),
                    onPressed: () {
                      pickImage(vm, ImageSource.gallery);
                    },
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: AppBtn(text: 'Save Progress'),
            )
          ] else ...[
            CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                pickImage(vm, ImageSource.camera);
              },
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
              onPressed: () async {
                pickImage(vm, ImageSource.gallery);
              },
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
          ]
        ],
      ),
    );
  }
}

pickImage(ProgressDetailVm vm, ImageSource source) async {
  ImagePicker imagePicker = ImagePicker();
  final pickedImage = await imagePicker.pickImage(source: source);
  if (pickedImage == null) return;
  vm.selectImage(File(pickedImage.path));
}
