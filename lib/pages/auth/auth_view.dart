import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:jorney/pages/auth/auth_vm.dart';
import 'package:jorney/pages/auth/create_account.dart';
import 'package:jorney/pages/auth/sign_in.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/loader_vm.dart';
import 'package:jorney/utils/styles.dart';
import 'package:jorney/widgets/app_btn.dart';

class AuthView extends ConsumerStatefulWidget {
  const AuthView({super.key});

  @override
  ConsumerState<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends ConsumerState<AuthView> {
  late PageController pageController;
  bool obscurePassword = true;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: pageController,
      children: [
        CreateAccount(goToSignInPage: () {
          ref.read(authVm.notifier).clearUser();
          pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
          );
        }),
        SignIn(goToSignIn: () {
          ref.read(authVm.notifier).clearUser();
          pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 200),
            curve: Curves.ease,
          );
        })
      ],
    );
  }
}
