import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/models/journey.dart';
import 'package:jorney/services/db_service.dart';

class HomeVm extends StateNotifier<List<Journey>?> {
  HomeVm() : super(null);
  final sercice = DbService();

  getJourneys(String userId) async {
    final res = await sercice.getJourneyList(userId);
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
