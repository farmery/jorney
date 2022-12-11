import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jorney/pages/new_journey/new_journey_vm.dart';
import 'package:jorney/services/auth_service.dart';
import 'package:jorney/utils/colors.dart';
import 'package:jorney/utils/notify_vm.dart';
import 'package:jorney/utils/styles.dart';
import '../../models/journey.dart';
import '../../widgets/app_btn.dart';
import '../../widgets/close_btn.dart';

class NewJourney extends ConsumerStatefulWidget {
  const NewJourney({super.key});
  static Route route() => CupertinoPageRoute(
        fullscreenDialog: true,
        builder: (_) => const NewJourney(),
      );
  @override
  ConsumerState<NewJourney> createState() => _NewJourneyState();
}

class _NewJourneyState extends ConsumerState<NewJourney> {
  @override
  Widget build(BuildContext context) {
    final vm = ref.watch(newJourneyVm.notifier);
    ref.watch(newJourneyVm);
    final colors = AppColors();
    final styles = TextStyles();
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: CupertinoPageScaffold(
        backgroundColor: colors.primaryBg,
        navigationBar: CupertinoNavigationBar(
          middle: const Text(
            'New Journey',
            style: TextStyle(color: Colors.white),
          ),
          padding: const EdgeInsetsDirectional.only(),
          backgroundColor: colors.primaryBg,
          leading: const CloseBtn(),
        ),
        child: Stack(
          children: [
            Scaffold(
              backgroundColor: colors.primaryBg,
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (!vm.validateTitle()) {
                          return 'Please enter a valid title';
                        }
                        return null;
                      },
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onChanged: vm.setTitle,
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
                        labelText: 'Journey Title',
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text('Progress Track Interval', style: styles.body),
                    const SizedBox(height: 4),
                    Text(
                      'How frequent do you want to track progress on your journey',
                      style: styles.subtitle2,
                    ),
                    const SizedBox(height: 16),
                    const JourneyTypeSelector(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(context).padding.bottom + 16,
              child: AppBtn(
                enabled: vm.validateTitle(),
                text: 'Start journey',
                onPressed: () async {
                  final notify = ref.read(notifyVm);
                  final user = ref.read(authStateChanges).value!;
                  final isSuccessful = await vm.startJourney(user.userId!);
                  if (!isSuccessful) {
                    return;
                  }
                  if (!mounted) return;
                  Navigator.pop(context, true);
                  notify.showMsg('Journey Created');
                  return;
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class JourneyTypeSelector extends ConsumerWidget {
  const JourneyTypeSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors();
    final styles = TextStyles();
    List<JourneyType> journeyTypes = [
      JourneyType.daily,
      JourneyType.weekly,
      JourneyType.monthly,
    ];
    final journey = ref.watch(newJourneyVm);
    final vm = ref.watch(newJourneyVm.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        journeyTypes.length,
        (index) {
          bool isSelected = journeyTypes[index] == journey.journeyType;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                vm.setJourneyType(journeyTypes[index]);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 16),
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelected ? colors.accent : colors.primaryCard,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  journeyTypes[index].name,
                  style: styles.body,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
