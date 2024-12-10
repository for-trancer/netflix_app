import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/failures/main_failures.dart';
import 'package:netflix_app/domain/new_and_hot/models/new_and_hot_response.dart';
import 'package:netflix_app/domain/new_and_hot/new_and_hot_service.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final NewAndHotService _hotAndNewService;
  //get hot and new movie data
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      //send loading to uo
      emit(const HotAndNewState(
          comingSoonList: [],
          everyoneIsWatchingList: [],
          isError: false,
          isLoading: true));
      //get data from result
      final _result = await _hotAndNewService.getNewAndHotMovieData();
      final newState = _result.fold((MainFailures f) {
        return const HotAndNewState(
            comingSoonList: [],
            everyoneIsWatchingList: [],
            isError: true,
            isLoading: false);
      }, (NewAndHotResponse response) {
        return HotAndNewState(
            comingSoonList: response.results!,
            everyoneIsWatchingList: state.everyoneIsWatchingList,
            isError: false,
            isLoading: false);
      });
      emit(newState);
    });
    //get hot and new tv data
    on<LoadDataInEveryoneIsWatching>((event, emit) async {
      //send loading to uo
      emit(const HotAndNewState(
          comingSoonList: [],
          everyoneIsWatchingList: [],
          isError: false,
          isLoading: true));
      //get data from result
      final _result = await _hotAndNewService.getNewAndHotTvData();
      final newState = _result.fold((MainFailures f) {
        return const HotAndNewState(
            comingSoonList: [],
            everyoneIsWatchingList: [],
            isError: true,
            isLoading: false);
      }, (NewAndHotResponse response) {
        return HotAndNewState(
            comingSoonList: state.comingSoonList,
            everyoneIsWatchingList: response.results!,
            isError: false,
            isLoading: false);
      });
      emit(newState);
    });
  }
}
