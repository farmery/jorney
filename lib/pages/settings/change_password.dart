import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/pages/auth/auth_vm.dart';
import 'package:jorney/services/auth_service.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/loader_vm.dart';
import 'package:jorney/utils/notify_vm.dart';
import '../../widgets/app_btn.dart';
import '../../widgets/close_btn.dart';

class ChangePassword extends ConsumerStatefulWidget {
  const ChangePassword({super.key});

  static Route get route => CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return const ChangePassword();
      });

  @override
  ConsumerState<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends ConsumerState<ChangePassword> {
  String password = '';
  String confirmPassword = '';
  bool validate() {
    if (password.length < 7) return false;
    if (password != confirmPassword) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Stack(
        children: [
          CupertinoPageScaffold(
            backgroundColor: colors.primaryBg,
            navigationBar: CupertinoNavigationBar(
              middle: const Text(
                'Change Password',
                style: TextStyle(color: Colors.white),
              ),
              padding: const EdgeInsetsDirectional.only(),
              backgroundColor: colors.primaryBg,
              leading: const CloseBtn(),
            ),
            child: Scaffold(
              backgroundColor: colors.primaryBg,
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Spacer(flex: 4),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null) {
                          return 'Enter a password';
                        } else if (value.length < 7) {
                          return 'Enter at least 7 characters';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        password = value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colors.secondaryBg,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colors.secondaryBg,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colors.secondaryBg,
                          ),
                        ),
                        labelText: 'New Password',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (!validate()) {
                          return 'The Passwords dont match';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        confirmPassword = value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: colors.secondaryBg,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colors.secondaryBg,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colors.secondaryBg,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                            color: colors.secondaryBg,
                          ),
                        ),
                        labelText: 'Confirm Password',
                      ),
                    ),
                    const Spacer(flex: 6),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16 + MediaQuery.of(context).padding.bottom,
            child: AppBtn(
              enabled: validate(),
              text: 'Save',
              onPressed: () async {
                AuthService authService = AuthService();
                final loader = ref.read(loaderVm.notifier);
                final notify = ref.read(notifyVm.notifier);
                final res = await loader
                    .load(() => authService.changePassword(password));
                if (res.error != null) {
                  notify.showMsg(res.error!);
                  return;
                }
                notify.showMsg(res.data!);
                if (!mounted) return;
                Navigator.pop(context);
                return;
              },
            ),
          )
        ],
      ),
    );
  }
}
