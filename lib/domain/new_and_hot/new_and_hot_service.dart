import 'package:dartz/dartz.dart';
import 'package:netflix_app/domain/core/failures/main_failures.dart';
import 'package:netflix_app/domain/new_and_hot/models/new_and_hot_response.dart';

abstract class NewAndHotService {
  Future<Either<MainFailures, NewAndHotResponse>> getNewAndHotMovieData();
  Future<Either<MainFailures, NewAndHotResponse>> getNewAndHotTvData();
}
