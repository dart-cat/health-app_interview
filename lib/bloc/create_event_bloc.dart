import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vstrecha/data/models/calendar_event.dart';

part 'create_event_event.dart';
part 'create_event_state.dart';

class CreateEventBloc extends Bloc<CreateEventEvent, CreateEventState> {
  CreateEventBloc() : super(CreateEventInitial()) {
    on<LoadCreateEvent>((event, emit) {
      emit(CreateEventInitial());
      emit(event.event != null
          ? CreateEventLoaded(
              title: event.event!.title,
              description: event.event!.description ?? '',
              startDate: event.event!.startDate ?? DateTime.now(),
              endDate: event.event!.endDate ?? DateTime.now(),
              frequency: event.event!.frequency ?? Frequency.once,
              times: event.event!.times,
              remindBefore:
                  event.event!.remindBefore ?? const Duration(minutes: 5),
              event: event.event!,
            )
          : CreateEventLoaded(
              title: EventType.appointment,
              description: '',
              startDate: DateTime.now(),
              endDate: DateTime.now(),
              frequency: Frequency.once,
              times: [DateTime(2023)],
              remindBefore: const Duration(minutes: 5),
            ));
    });

    on<SetEventTitle>((event, emit) {
      if (state is CreateEventLoaded) {
        final s = state as CreateEventLoaded;
        emit(CreateEventInitial());
        emit(CreateEventLoaded(
          title: event.title,
          description: s.description,
          startDate: s.startDate,
          endDate: s.endDate,
          frequency: s.frequency,
          times: s.times,
          remindBefore: s.remindBefore,
          event: s.event,
        ));
      }
    });

    on<SetEventDescription>((event, emit) {
      if (state is CreateEventLoaded) {
        final s = state as CreateEventLoaded;
        emit(CreateEventInitial());
        emit(CreateEventLoaded(
          title: s.title,
          description: event.description,
          startDate: s.startDate,
          endDate: s.endDate,
          frequency: s.frequency,
          times: s.times,
          remindBefore: s.remindBefore,
          event: s.event,
        ));
      }
    });

    on<SetEventStartDate>((event, emit) {
      if (state is CreateEventLoaded) {
        final s = state as CreateEventLoaded;
        emit(CreateEventInitial());
        emit(CreateEventLoaded(
          title: s.title,
          description: s.description,
          startDate: event.startDate,
          endDate: s.endDate,
          frequency: s.frequency,
          times: s.times,
          remindBefore: s.remindBefore,
          event: s.event,
        ));
      }
    });

    on<SetEventEndDate>((event, emit) {
      if (state is CreateEventLoaded) {
        final s = state as CreateEventLoaded;
        emit(CreateEventInitial());
        emit(CreateEventLoaded(
          title: s.title,
          description: s.description,
          startDate: s.startDate,
          endDate: event.endDate,
          frequency: s.frequency,
          times: s.times,
          remindBefore: s.remindBefore,
          event: s.event,
        ));
      }
    });

    on<SetEventFrequency>((event, emit) {
      if (state is CreateEventLoaded) {
        final s = state as CreateEventLoaded;
        emit(CreateEventInitial());
        emit(CreateEventLoaded(
          title: s.title,
          description: s.description,
          startDate: s.startDate,
          endDate: s.endDate,
          frequency: event.frequency,
          times: s.times,
          remindBefore: s.remindBefore,
          event: s.event,
        ));
      }
    });

    on<SetEventTimes>((event, emit) {
      if (state is CreateEventLoaded) {
        final s = state as CreateEventLoaded;
        emit(CreateEventInitial());
        emit(CreateEventLoaded(
          title: s.title,
          description: s.description,
          startDate: s.startDate,
          endDate: s.endDate,
          frequency: s.frequency,
          times: event.times,
          remindBefore: s.remindBefore,
          event: s.event,
        ));
      }
    });

    on<SetEventRemindBefore>((event, emit) {
      if (state is CreateEventLoaded) {
        final s = state as CreateEventLoaded;
        emit(CreateEventInitial());
        emit(CreateEventLoaded(
          title: s.title,
          description: s.description,
          startDate: s.startDate,
          endDate: s.endDate,
          frequency: s.frequency,
          times: s.times,
          remindBefore: event.remindBefore,
          event: s.event,
        ));
      }
    });
  }
}
