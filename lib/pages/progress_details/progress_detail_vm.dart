import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/services/db_service.dart';

class ProgressDetailVm extends StateNotifier<File?> {
  ProgressDetailVm() : super(null);
  DbService dbService = DbService();

  updateProgress(String progressId) async {
    if (state == null) return;
    await dbService.updateProgressWithImage(progressId, state!);
  }

  selectImage(File file) {
    state = file;
  }
}

final progressDetailVm = StateNotifierProvider<ProgressDetailVm, File?>((ref) {
  return ProgressDetailVm();
});
