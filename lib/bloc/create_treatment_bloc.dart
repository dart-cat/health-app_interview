import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vstrecha/data/models/treatment.dart';

part 'create_treatment_event.dart';
part 'create_treatment_state.dart';

class CreateTreatmentBloc
    extends Bloc<CreateTreatmentEvent, CreateTreatmentState> {
  CreateTreatmentBloc() : super(CreateTreatmentInitial()) {
    on<LoadCreateTreatment>((event, emit) {
      emit(CreateTreatmentInitial());
      emit(event.item != null
          ? CreateTreatmentLoaded(
              title: event.item!.title,
              startDate: event.item!.startDate ?? DateTime.now(),
              endDate: event.item!.endDate ?? DateTime.now(),
              frequency: event.item!.frequency ?? Frequency.once,
              times: event.item!.times,
              remindBefore:
                  event.item!.remindBefore ?? const Duration(minutes: 5),
              item: event.item,
            )
          : CreateTreatmentLoaded(
              title: '',
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              frequency: Frequency.once,
              times: [DateTime(2023)],
              remindBefore: const Duration(minutes: 5),
            ));
    });

    on<SetTreatmentTitle>((event, emit) {
      if (state is CreateTreatmentLoaded) {
        final s = state as CreateTreatmentLoaded;
        emit(CreateTreatmentInitial());
        emit(CreateTreatmentLoaded(
          title: event.title,
          startDate: s.startDate,
          endDate: s.endDate,
          frequency: s.frequency,
          times: s.times,
          remindBefore: s.remindBefore,
          item: s.item,
        ));
      }
    });

    on<SetTreatmentStartDate>((event, emit) {
      if (state is CreateTreatmentLoaded) {
        final s = state as CreateTreatmentLoaded;
        emit(CreateTreatmentInitial());
        emit(CreateTreatmentLoaded(
          title: s.title,
          startDate: event.startDate,
          endDate: s.endDate,
          frequency: s.frequency,
          times: s.times,
          remindBefore: s.remindBefore,
          item: s.item,
        ));
      }
    });

    on<SetTreatmentEndDate>((event, emit) {
      if (state is CreateTreatmentLoaded) {
        final s = state as CreateTreatmentLoaded;
        emit(CreateTreatmentInitial());
        emit(CreateTreatmentLoaded(
          title: s.title,
          startDate: s.startDate,
          endDate: event.endDate,
          frequency: s.frequency,
          times: s.times,
          remindBefore: s.remindBefore,
          item: s.item,
        ));
      }
    });

    on<SetTreatmentFrequency>((event, emit) {
      if (state is CreateTreatmentLoaded) {
        final s = state as CreateTreatmentLoaded;
        emit(CreateTreatmentInitial());
        emit(CreateTreatmentLoaded(
          title: s.title,
          startDate: s.startDate,
          endDate: s.endDate,
          frequency: event.frequency,
          times: s.times,
          remindBefore: s.remindBefore,
          item: s.item,
        ));
      }
    });

    on<SetTreatmentTimes>((event, emit) {
      if (state is CreateTreatmentLoaded) {
        final s = state as CreateTreatmentLoaded;
        emit(CreateTreatmentInitial());
        emit(CreateTreatmentLoaded(
          title: s.title,
          startDate: s.startDate,
          endDate: s.endDate,
          frequency: s.frequency,
          times: event.times,
          remindBefore: s.remindBefore,
          item: s.item,
        ));
      }
    });

    on<SetTreatmentRemindBefore>((event, emit) {
      if (state is CreateTreatmentLoaded) {
        final s = state as CreateTreatmentLoaded;
        emit(CreateTreatmentInitial());
        emit(CreateTreatmentLoaded(
          title: s.title,
          startDate: s.startDate,
          endDate: s.endDate,
          frequency: s.frequency,
          times: s.times,
          remindBefore: event.remindBefore,
          item: s.item,
        ));
      }
    });
  }
}
