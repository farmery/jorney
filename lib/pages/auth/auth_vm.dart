import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/services/auth_service.dart';

import '../../models/user.dart';

class AuthVm extends StateNotifier<User> {
  AuthVm() : super(User());

  AuthService authService = AuthService();

  clearUser() {
    state = User();
  }

  setEmail(String email) {
    state = state.copyWith(email: email);
  }

  setDisplayName(String displayName) {
    state = state.copyWith(displayName: displayName);
  }

  setPassword(String password) {
    state = state.copyWith(password: password);
  }

  Future resetPassword(Function(String) onError) async {
    final res = await authService.resetPassword(state.email!);
    if (res.error != null) {
      onError(res.error!);
    }
  }

  validateCreateAccount() {
    if (state.displayName == null || state.displayName!.isEmpty) return false;
    if (state.email == null || state.email!.isEmpty) return false;
    if (state.password == null || state.password!.length < 5) return false;
    return true;
  }

  validateSignIn() {
    if (state.email == null || state.email!.isEmpty) return false;
    if (state.password == null || state.password!.length < 5) return false;
    return true;
  }

  Future createAccount(
      Function(String) onSuccess, Function(String) onError) async {
    final res = await authService.createAccount(state);
    if (res.error != null) {
      onError(res.error!);
      return;
    }
    onSuccess('Account Created Successfully');
    return;
  }

  signIn(Function(String) onSuccess, Function(String) onError) async {
    final res = await authService.signInUser(state);
    if (res.error != null) {
      onError(res.error!);
      return;
    }
    onSuccess('Signed in Successfully');
    return;
  }
}

final authVm = StateNotifierProvider<AuthVm, User>((ref) {
  return AuthVm();
});
