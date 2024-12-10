// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:netflix_app/application/downloads/downloads_bloc.dart' as _i664;
import 'package:netflix_app/application/fast_laugh/fast_laugh_bloc.dart'
    as _i878;
import 'package:netflix_app/application/home/home_bloc.dart' as _i778;
import 'package:netflix_app/application/hot_and_new/hot_and_new_bloc.dart'
    as _i318;
import 'package:netflix_app/application/search/search_bloc.dart' as _i771;
import 'package:netflix_app/domain/downloads/i_downloads_repo.dart' as _i437;
import 'package:netflix_app/domain/new_and_hot/new_and_hot_service.dart'
    as _i109;
import 'package:netflix_app/domain/search/search_service.dart' as _i75;
import 'package:netflix_app/infrastructure/downloads/downloads_repository.dart'
    as _i684;
import 'package:netflix_app/infrastructure/new_and_hot/new_and_hot_implementation.dart'
    as _i266;
import 'package:netflix_app/infrastructure/search/search_implementaion.dart'
    as _i396;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i75.SearchService>(() => _i396.SearchImplementaion());
    gh.lazySingleton<_i109.NewAndHotService>(
        () => _i266.NewAndHotImplementation());
    gh.lazySingleton<_i437.IDownloadsRepo>(() => _i684.DownloadsRepository());
    gh.factory<_i878.FastLaughBloc>(
        () => _i878.FastLaughBloc(gh<_i437.IDownloadsRepo>()));
    gh.factory<_i778.HomeBloc>(
        () => _i778.HomeBloc(gh<_i109.NewAndHotService>()));
    gh.factory<_i664.DownloadsBloc>(
        () => _i664.DownloadsBloc(gh<_i437.IDownloadsRepo>()));
    gh.factory<_i318.HotAndNewBloc>(
        () => _i318.HotAndNewBloc(gh<_i109.NewAndHotService>()));
    gh.factory<_i771.SearchBloc>(() => _i771.SearchBloc(
          gh<_i75.SearchService>(),
          gh<_i437.IDownloadsRepo>(),
        ));
    return this;
  }
}
