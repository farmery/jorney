import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jorney/utils/notify_vm.dart';

import '../../utils/colors.dart';
import '../../utils/loader_vm.dart';
import '../../utils/styles.dart';
import '../../widgets/app_btn.dart';
import 'auth_vm.dart';

class SignIn extends ConsumerStatefulWidget {
  const SignIn({super.key, required this.goToSignIn});
  final VoidCallback goToSignIn;

  @override
  ConsumerState<SignIn> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignIn> {
  bool obscurePassword = true;
  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    final styles = TextStyles();
    final user = ref.watch(authVm);
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
          Scaffold(
            backgroundColor: colors.primaryBg,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Spacer(flex: 4),
                  SvgPicture.asset('assets/icons/logo.svg'),
                  const SizedBox(height: 16),
                  Text(
                    'Sign in to your Account',
                    style: styles.subtitle1,
                  ),
                  const Spacer(flex: 1),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value == null) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                    onChanged: ref.read(authVm.notifier).setEmail,
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
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    onChanged: ref.read(authVm.notifier).setPassword,
                    obscureText: obscurePassword,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                          });
                        },
                        child: Icon(
                          obscurePassword
                              ? CupertinoIcons.eye_slash
                              : CupertinoIcons.eye,
                        ),
                      ),
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
                      labelText: 'Password',
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: resetPassword,
                      child: Text(
                        'Forgot password?',
                        style: (user.email == null || user.email!.isEmpty)
                            ? styles.subtitle2
                            : styles.subtitle2
                                .copyWith(color: colors.primaryTextColor),
                      ),
                    ),
                  ),
                  CupertinoButton(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: colors.accent),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        "Don't have an account?",
                        style: styles.body.copyWith(color: colors.accent),
                      ),
                    ),
                    onPressed: () {
                      widget.goToSignIn();
                    },
                  ),
                  const Spacer(flex: 6),
                ],
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16 + MediaQuery.of(context).padding.bottom,
            child: AppBtn(
              enabled: ref.watch(authVm.notifier).validateSignIn(),
              text: 'Sign in',
              onPressed: signIn,
            ),
          )
        ],
      ),
    );
  }

  signIn() {
    final notify = ref.read(notifyVm.notifier);
    onSuccess(String msg) {
      notify.showMsg(msg, 3);
    }

    onError(String msg) {
      notify.showMsg(msg, 8);
    }

    final loader = ref.read(loaderVm.notifier);
    loader.load(() {
      return ref.read(authVm.notifier).signIn(onSuccess, onError);
    });
  }

  resetPassword() {
    final loader = ref.read(loaderVm.notifier);
    onError(String msg) {
      final notify = ref.read(notifyVm.notifier);
      notify.showMsg(msg, 8);
    }

    loader.load(() => ref.read(authVm.notifier).resetPassword(onError));
  }
}
