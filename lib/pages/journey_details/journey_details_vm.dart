import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/api/journey_service.dart';
import 'package:jorney/models/progress.dart';

class ProgressVm extends StateNotifier<List<Progress>?> {
  ProgressVm() : super(null);
  final service = JourneyService();

  getProgress(String journeyId) async {
    final res = await service.getProgress(journeyId);
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
