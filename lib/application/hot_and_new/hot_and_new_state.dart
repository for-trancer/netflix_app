part of 'hot_and_new_bloc.dart';

@freezed
class HotAndNewState with _$HotAndNewState {
  const factory HotAndNewState({
    required List<NewAndHotData> comingSoonList,
    required List<NewAndHotData> everyoneIsWatchingList,
    required bool isError,
    required bool isLoading,
  }) = _Initial;

  factory HotAndNewState.initial() => const HotAndNewState(
        comingSoonList: [],
        everyoneIsWatchingList: [],
        isError: false,
        isLoading: false,
      );
}
