import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoaderVm extends ChangeNotifier {
  bool isLoading = false;
  bool silent = false;
  Future<T> load<T>(Future<T> Function() future, {bool silent = false}) async {
    this.silent = silent;
    isLoading = true;
    notifyListeners();
    final T val = await future();
    isLoading = false;
    notifyListeners();
    return val;
  }

  toggleLoader(bool val) {
    isLoading = val;
    notifyListeners();
  }
}

final loaderVm = ChangeNotifierProvider<LoaderVm>((ref) {
  return LoaderVm();
});
