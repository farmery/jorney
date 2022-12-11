import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/services/db_service.dart';
import 'package:jorney/utils/constants.dart';

import '../../models/journey.dart';

class NewJourneyVm extends StateNotifier<Journey> {
  NewJourneyVm() : super(Journey(journeyType: JourneyType.monthly));
  DbService service = DbService();
  setTitle(String val) {
    state = state.copyWith(title: val);
  }

  setJourneyType(JourneyType type) {
    state = state.copyWith(journeyType: type);
  }

  Future<bool> startJourney(String userId) async {
    state = state.copyWith(
      maxLevel: journeyLengthLimits[state.journeyType],
      userId: userId,
      createdAt: DateTime.now(),
      startDate: DateTime(2022, 1, 1, 8),
    );
    await service.newJourney(state);
    return true;
  }

  bool validateTitle() {
    if (state.title == null || state.title!.isEmpty) return false;
    return true;
  }
}

final newJourneyVm = StateNotifierProvider<NewJourneyVm, Journey>((ref) {
  return NewJourneyVm();
});
