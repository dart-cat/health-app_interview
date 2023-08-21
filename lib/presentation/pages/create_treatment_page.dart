import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localization/localization.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:vstrecha/bloc/create_treatment_bloc.dart';
import 'package:vstrecha/bloc/main_bloc.dart';
import 'package:vstrecha/bloc/treatment_bloc.dart';
import 'package:vstrecha/data/models/treatment.dart';
import 'package:vstrecha/presentation/widgets/button.dart';
import 'package:vstrecha/presentation/widgets/date_picker.dart';
import 'package:vstrecha/presentation/widgets/dropdown.dart';
import 'package:vstrecha/presentation/widgets/main_input.dart';
import 'package:vstrecha/presentation/widgets/page_header.dart';
import 'package:vstrecha/presentation/widgets/wheel_picker.dart';

class CreateTreatmentPage extends StatefulWidget {
  const CreateTreatmentPage({super.key});

  @override
  State<CreateTreatmentPage> createState() => _CreateTreatmentPageState();
}

class _CreateTreatmentPageState extends State<CreateTreatmentPage> {
  final PanelController _timeController = PanelController();
  final PanelController _remindController = PanelController();

  final List<String> _frequencyItems = [
    'once'.i18n(),
    'daily'.i18n(),
    'once-a-week'.i18n(),
    'once-a-month'.i18n(),
  ];

  void _onBackAction() {
    BackButtonInterceptor.removeAll();
    _timeController.close();
    _remindController.close();
    MainBloc main = BlocProvider.of<MainBloc>(context);
    main.add(PopPageEvent());
  }

  void _removeItem(CreateTreatmentLoaded state) {
    if (state.item != null) {
      BlocProvider.of<TreatmentBloc>(context)
          .add(RemoveTreatment(treatment: state.item!));
    }
  }

  @override
  Widget build(BuildContext context) {
    final CreateTreatmentBloc bloc =
        BlocProvider.of<CreateTreatmentBloc>(context);
    return BlocBuilder<CreateTreatmentBloc, CreateTreatmentState>(
      builder: (context, state) {
        if (state is CreateTreatmentLoaded) {
          return Column(
            children: [
              PageHeader(
                title: 'treatment-regimen'.i18n(),
                actionText: 'delete'.i18n(),
                onBackAction: _onBackAction,
                onActionTap: () {
                  _removeItem(state);
                  _onBackAction();
                },
              ),
              Expanded(
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: ListView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        child: MainInput(
                          hint: 'treatment-title'.i18n(),
                          label: 'treatment-title'.i18n(),
                          isRequired: false,
                          value: state.title,
                          onChanged: (value) =>
                              bloc.add(SetTreatmentTitle(title: value)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 8,
                          right: 8,
                        ),
                        child: DatePicker(
                          label: 'treatment-start-date'.i18n(),
                          value: state.startDate,
                          onChanged: (value) =>
                              bloc.add(SetTreatmentStartDate(startDate: value)),
                          isRequired: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 8,
                          right: 8,
                        ),
                        child: DatePicker(
                          label: 'treatment-end-date'.i18n(),
                          value: state.endDate,
                          onChanged: (value) =>
                              bloc.add(SetTreatmentEndDate(endDate: value)),
                          isRequired: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 8,
                          right: 8,
                        ),
                        child: DropDown(
                          items: _frequencyItems,
                          label: 'frequency'.i18n(),
                          hint: 'frequency'.i18n(),
                          isRequired: false,
                          value: _freqToString(state.frequency),
                          onChanged: (value) {
                            final index = _frequencyItems.indexOf(value);
                            switch (index) {
                              case 0:
                                bloc.add(const SetTreatmentFrequency(
                                    frequency: Frequency.once));
                                break;
                              case 1:
                                bloc.add(const SetTreatmentFrequency(
                                    frequency: Frequency.daily));
                                break;
                              case 2:
                                bloc.add(const SetTreatmentFrequency(
                                    frequency: Frequency.onceAWeek));
                                break;
                              case 3:
                                bloc.add(const SetTreatmentFrequency(
                                    frequency: Frequency.onceAMonth));
                                break;
                              default:
                                break;
                            }
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 8,
                          right: 8,
                        ),
                        child: WheelPicker(
                          controller: _timeController,
                          items: List.generate(
                              24,
                              (index) =>
                                  '${index.toString().padLeft(2, '0')}:00'),
                          label: 'treatment-time'.i18n(),
                          value:
                              '${state.times.first.hour.toString().padLeft(2, '0')}:00',
                          onChanged: (value) {
                            final hour = int.tryParse(value.substring(0, 2));
                            bloc.add(
                              SetTreatmentTimes(
                                times: [DateTime(2023, 1, 1, hour ?? 0)],
                              ),
                            );
                          },
                          isRequired: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 8,
                          right: 8,
                        ),
                        child: WheelPicker(
                          controller: _remindController,
                          items: List.generate(
                            12,
                            (index) => '${(index + 1) * 5} ${'minutes'.i18n()}',
                          ),
                          label: 'treatment-remind'.i18n(),
                          value:
                              '${state.remindBefore.inMinutes} ${'minutes'.i18n()}',
                          onChanged: (value) {
                            final minutes = int.tryParse(value.split(' ')[0]);
                            if (minutes != null) {
                              bloc.add(
                                SetTreatmentRemindBefore(
                                  remindBefore: Duration(minutes: minutes),
                                ),
                              );
                            }
                          },
                          isRequired: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16,
                          left: 8,
                          right: 8,
                          bottom: 16,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 144,
                              child: MainButton(
                                onTap: () {
                                  MainBloc main =
                                      BlocProvider.of<MainBloc>(context);
                                  TreatmentBloc treatment =
                                      BlocProvider.of<TreatmentBloc>(context);
                                  if (state.item != null) {
                                    treatment.add(UpdateTreatment(
                                      oldItem: state.item!,
                                      newItem: TreatmentItem(
                                        title: state.title,
                                        startDate: _startDate(state.startDate),
                                        endDate: _endDate(state.endDate),
                                        frequency: state.frequency,
                                        times: state.times,
                                        remindBefore: state.remindBefore,
                                      ),
                                    ));
                                  } else {
                                    treatment.add(AddTreatment(
                                      treatment: TreatmentItem(
                                        title: state.title,
                                        startDate: _startDate(state.startDate),
                                        endDate: _endDate(state.endDate),
                                        frequency: state.frequency,
                                        times: state.times,
                                        remindBefore: state.remindBefore,
                                      ),
                                    ));
                                  }
                                  main.add(PopPageEvent());
                                },
                                enabled: true,
                                label: 'create'.i18n(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  DateTime _startDate(DateTime date) {
    return DateTime(date.year, date.month, date.day, 0);
  }

  DateTime _endDate(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59);
  }

  String _freqToString(Frequency freq) {
    switch (freq) {
      case Frequency.once:
        return 'once'.i18n();
      case Frequency.daily:
        return 'daily'.i18n();
      case Frequency.onceAWeek:
        return 'once-a-week'.i18n();
      case Frequency.onceAMonth:
        return 'once-a-month'.i18n();
      case Frequency.everyFewDays:
        return 'every-few-days'.i18n();
      default:
        return '';
    }
  }
}
