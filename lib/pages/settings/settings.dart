import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/pages/settings/change_email.dart';
import 'package:jorney/pages/settings/change_password.dart';
import 'package:jorney/services/auth_service.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/loader_vm.dart';
import 'package:jorney/utils/styles.dart';

import '../../widgets/animated_chip.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {});
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    final styles = TextStyles();
    final settings = {
      'Change Password': Icon(Icons.password, color: colors.primaryTextColor),
      'Change Email':
          Icon(Icons.alternate_email_rounded, color: colors.primaryTextColor),
      'Contact us': Icon(CupertinoIcons.mail, color: colors.primaryTextColor),
      'Logout': Icon(Icons.login_outlined, color: colors.primaryTextColor)
    };
    final user = ref.watch(authStateChanges).value;
    return CupertinoPageScaffold(
      backgroundColor: colors.primaryBg,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            CupertinoSliverNavigationBar(
              backgroundColor: colors.primaryBg.withOpacity(0.5),
              largeTitle: const Text(
                'Settings',
                style: TextStyle(color: Colors.white),
              ),
            )
          ];
        },
        body: Scaffold(
          backgroundColor: colors.primaryBg,
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(
                children: [
                  const Icon(CupertinoIcons.person_alt_circle, size: 30),
                  const SizedBox(width: 16),
                  Text(user!.email!, style: styles.title),
                ],
              ),
              const SizedBox(height: 30),
              Wrap(
                children: settings.entries
                    .map(
                      (e) => CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          switch (e.key) {
                            case 'Change Password':
                              Navigator.push(context, ChangePassword.route);
                              break;
                            case 'Change Email':
                              Navigator.push(context, ChangeEmail.route);
                              break;
                            case 'Logout':
                              final loader = ref.read(loaderVm.notifier);
                              loader.load(() => AuthService().signOut());
                              break;
                            default:
                          }
                        },
                        child: FloatingChip(e: e),
                      ),
                    )
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
