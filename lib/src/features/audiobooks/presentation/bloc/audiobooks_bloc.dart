import 'package:audiobooks/src/core/di/service_locator.dart';
import 'package:audiobooks/src/core/usecases/no_params.dart';
import 'package:audiobooks/src/features/audiobooks/domain/entities/audiobook_entity.dart';
import 'package:audiobooks/src/features/audiobooks/domain/usecases/get_audiobooks_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'audiobooks_event.dart';
part 'audiobooks_state.dart';

class AudiobooksBloc extends Bloc<AudiobooksEvent, AudiobooksState> {
  AudiobooksBloc({
    required GetAudiobooksUseCase getAudiobooksUsecase,
  }) : super(AudiobooksInitial()) {
    on<GetAudiobooksEvent>(
      (event, emit) async {
        emit(AudiobooksLoading());
        final result = await sl<GetAudiobooksUseCase>().call(NoParams());

        result.fold(
          (failure) => emit(AudiobooksError(failure.toString())),
          (meals) => emit(AudiobooksLoaded(meals)),
        );
      },
    );
  }
}
