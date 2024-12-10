import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failures.dart';
import 'package:netflix_app/domain/downloads/i_downloads_repo.dart';
import 'package:netflix_app/domain/downloads/models/downloads.dart';

part 'downloads_event.dart';
part 'downloads_state.dart';

part 'downloads_bloc.freezed.dart';

@injectable
class DownloadsBloc extends Bloc<DownloadsEvent, DownloadsState> {
  final IDownloadsRepo _downloadsRepo;

  DownloadsBloc(this._downloadsRepo) : super(DownloadsState.initial()) {
    on<_getDownloadsImage>((event, emit) async {
      emit(
        state.copyWith(
          isLoading: true,
          downloadsFailureOrSucessOption: none(),
        ),
      );
      final Either<MainFailures, List<Downloads>> downloadsOption =
          await _downloadsRepo.getDownloadsImages();
      emit(downloadsOption.fold(
        (failure) => state.copyWith(
          isLoading: false,
          downloadsFailureOrSucessOption: Some(
            Left(failure),
          ),
        ),
        (success) => state.copyWith(
          isLoading: false,
          downloads: success,
          downloadsFailureOrSucessOption: Some(
            Right(success),
          ),
        ),
      ));
    });
  }
}
