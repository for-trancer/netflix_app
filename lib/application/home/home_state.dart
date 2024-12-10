part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required String stateId,
    required List<NewAndHotData> pastYearMovieList,
    required List<NewAndHotData> trendingMovieList,
    required List<NewAndHotData> tenseDramasMovieList,
    required List<NewAndHotData> southIndianMovieList,
    required List<NewAndHotData> trendingTvList,
    required bool isLoading,
    required bool isError,
  }) = _Initial;
  factory HomeState.initial() => const HomeState(
      stateId: '0',
      pastYearMovieList: [],
      trendingMovieList: [],
      tenseDramasMovieList: [],
      southIndianMovieList: [],
      trendingTvList: [],
      isLoading: false,
      isError: false);
}
