import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/journey.dart';

class NewJourneyVm extends StateNotifier<Journey> {
  NewJourneyVm() : super(Journey());

  // set
}

final newJourneyVm = StateNotifierProvider<NewJourneyVm, Journey>((ref) {
  return NewJourneyVm();
});
