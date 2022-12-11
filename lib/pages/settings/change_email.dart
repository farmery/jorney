import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/services/auth_service.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/loader_vm.dart';
import 'package:jorney/utils/notify_vm.dart';
import 'package:jorney/utils/validate_email.dart';
import '../../widgets/app_btn.dart';
import '../../widgets/close_btn.dart';

class ChangeEmail extends ConsumerStatefulWidget {
  const ChangeEmail({super.key});

  static Route get route => CupertinoPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return const ChangeEmail();
      });

  @override
  ConsumerState<ChangeEmail> createState() => _ChangeEmailState();
}

class _ChangeEmailState extends ConsumerState<ChangeEmail> {
  String email = '';
  bool validate() {
    if (email.length < 5) return false;
    return ValidateEmail.isEmailValid(email);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(authStateChanges).value!;
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
                'Change Email',
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
                      initialValue: user.email,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (!validate()) {
                          return 'Please enter a valid Email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        email = value;
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
                        labelText: 'New Email',
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
                final res =
                    await loader.load(() => authService.updateUserEmail(email));
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
