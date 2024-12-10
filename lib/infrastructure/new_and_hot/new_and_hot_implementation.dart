import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix_app/domain/core/api_end_points.dart';
import 'package:netflix_app/domain/core/failures/main_failures.dart';
import 'package:netflix_app/domain/new_and_hot/models/new_and_hot_response.dart';
import 'package:netflix_app/domain/new_and_hot/new_and_hot_service.dart';

@LazySingleton(as: NewAndHotService)
class NewAndHotImplementation implements NewAndHotService {
  @override
  Future<Either<MainFailures, NewAndHotResponse>>
      getNewAndHotMovieData() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.newAndHotMovie);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = NewAndHotResponse.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailures.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailures.clientFailure());
    }
  }

  @override
  Future<Either<MainFailures, NewAndHotResponse>> getNewAndHotTvData() async {
    try {
      final Response response =
          await Dio(BaseOptions()).get(ApiEndPoints.newAndHotTv);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = NewAndHotResponse.fromJson(response.data);
        return Right(result);
      } else {
        return const Left(MainFailures.serverFailure());
      }
    } catch (e) {
      log(e.toString());
      return const Left(MainFailures.clientFailure());
    }
  }
}
