import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/models/progress.dart';
import 'package:jorney/services/db_service.dart';

class ProgressVm extends StateNotifier<List<Progress>?> {
  ProgressVm() : super(null);
  final service = DbService();

  getProgressList(String journeyId) async {
    final res = await service.getProgressList(journeyId);
    if (res.error != null) {
      state = null;
      return;
    }
    state = res.data;
    return;
  }
}

final progressVm = StateNotifierProvider<ProgressVm, List<Progress>?>((ref) {
  return ProgressVm();
});
