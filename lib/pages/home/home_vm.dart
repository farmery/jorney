import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/models/journey.dart';

import '../../api/journey_service.dart';

class HomeVm extends StateNotifier<List<Journey>?> {
  HomeVm() : super(null);
  final journeyService = JourneyService();

  getJourneys() async {
    final res = await journeyService.getJourneys();
    if (res.error != null) {
      state = [];
      return;
    }
    state = res.data;
  }
}

final homeVm = StateNotifierProvider<HomeVm, List<Journey>?>((ref) {
  return HomeVm();
});
