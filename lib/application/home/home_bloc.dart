import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failures.dart';
import 'package:netflix_app/domain/new_and_hot/models/new_and_hot_response.dart';
import 'package:netflix_app/domain/new_and_hot/new_and_hot_service.dart';
part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewAndHotService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
    // on event get home screen data

    on<GetHomeScreenData>((event, emit) async {
      // send loading to ui
      emit(state.copyWith(isLoading: true, isError: false));
      //get data

      final _movieResult = await _homeService.getNewAndHotMovieData();
      final _tvResult = await _homeService.getNewAndHotTvData();

      // tranform data

      final _state1 = _movieResult.fold((MainFailures failure) {
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramasMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          isError: true,
        );
      }, (NewAndHotResponse response) {
        final pastYear = response.results;
        final trending = response.results;
        final dramas = response.results;
        final southIndian = response.results;
        pastYear!.shuffle();
        trending!.shuffle();
        dramas!.shuffle();
        southIndian!.shuffle();
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: pastYear,
          trendingMovieList: trending,
          tenseDramasMovieList: dramas,
          southIndianMovieList: southIndian,
          trendingTvList: state.trendingTvList,
          isLoading: false,
          isError: false,
        );
      });

      emit(_state1);

      final _state2 = _tvResult.fold((MainFailures failure) {
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseDramasMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          isError: true,
        );
      }, (NewAndHotResponse response) {
        final top10List = response.results;
        return HomeState(
          stateId: DateTime.now().millisecondsSinceEpoch.toString(),
          pastYearMovieList: state.pastYearMovieList,
          trendingMovieList: state.trendingMovieList,
          tenseDramasMovieList: state.tenseDramasMovieList,
          southIndianMovieList: state.southIndianMovieList,
          trendingTvList: top10List!,
          isLoading: false,
          isError: true,
        );
      });

      //send to ui

      emit(_state2);
    });
  }
}
