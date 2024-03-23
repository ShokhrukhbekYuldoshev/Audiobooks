import 'package:audiobooks/src/core/usecases/no_params.dart';
import 'package:audiobooks/src/domain/entities/audiobook_entity.dart';
import 'package:audiobooks/src/domain/entities/author_entity.dart';
import 'package:audiobooks/src/domain/usecases/get_audiobooks_usecase.dart';
import 'package:audiobooks/src/domain/usecases/get_authors_usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetAudiobooksUseCase getAudiobooksUseCase;
  final GetAuthorsUseCase getAuthorsUseCase;
  HomeBloc({
    required this.getAudiobooksUseCase,
    required this.getAuthorsUseCase,
  }) : super(HomeInitial()) {
    on<GetHomePageEvent>(_onGetHomePageEvent);
  }

  void _onGetHomePageEvent(
    GetHomePageEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    final audiobooksResult = await getAudiobooksUseCase.call(NoParams());
    List<AudiobookEntity> audiobooks = [];
    audiobooksResult.fold(
      (failure) => emit(HomeError(failure.toString())),
      (success) => audiobooks = success,
    );

    final authorsResult = await getAuthorsUseCase.call(NoParams());
    List<AuthorEntity> authors = [];
    authorsResult.fold(
      (failure) => emit(HomeError(failure.toString())),
      (success) => authors = success,
    );

    emit(
      HomeLoaded(
        audiobooks: audiobooks,
        authors: authors,
      ),
    );
  }
}
