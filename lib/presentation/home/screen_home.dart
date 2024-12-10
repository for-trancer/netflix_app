import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/home/home_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants/constants.dart';
import 'package:netflix_app/core/constants/strings.dart';
import 'package:netflix_app/presentation/home/widgets/background_card.dart';
import 'package:netflix_app/presentation/home/widgets/main_title_card.dart';
import 'package:netflix_app/presentation/home/widgets/number_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: scrollNotifier,
          builder: (BuildContext context, index, _) {
            return NotificationListener<UserScrollNotification>(
              onNotification: (notification) {
                final ScrollDirection direction = notification.direction;
                if (direction == ScrollDirection.reverse) {
                  scrollNotifier.value = false;
                } else if (direction == ScrollDirection.forward) {
                  scrollNotifier.value = true;
                }
                return true;
              },
              child: Stack(
                children: [
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                    if (state.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      );
                    } /*else if (state.isError) {
                      return const Center(
                        child: Text(
                          'Please Reload',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }*/
                    // error is bugged
                    else {
                      //released past year
                      final _releasedPastYear =
                          state.pastYearMovieList.map((m) {
                        return '$imageUrl${m.posterPath}';
                      }).toList();
                      //trending now
                      final _trendingNow = state.trendingMovieList.map((m) {
                        return '$imageUrl${m.posterPath}';
                      }).toList();
                      //tense dramas
                      final _tenseDramas = state.tenseDramasMovieList.map((m) {
                        return '$imageUrl${m.posterPath}';
                      }).toList();
                      //south indian
                      final _southIndian = state.southIndianMovieList.map((m) {
                        return '$imageUrl${m.posterPath}';
                      }).toList();
                      final _tvShows = state.trendingTvList.map((m) {
                        return '$imageUrl${m.posterPath}';
                      }).toList();
                      _southIndian.shuffle();
                      return ListView(
                        children: [
                          const BackgroundCard(),
                          MainTitleCard(
                            title: "Released In The Past Year",
                            posterList: _releasedPastYear,
                          ),
                          MainTitleCard(
                            title: "Trending Now",
                            posterList: _trendingNow,
                          ),
                          NumberTitleCard(
                              postersList: _tvShows,
                              title: "Top 10 TV Shows In India Today"),
                          MainTitleCard(
                            title: "Tense Dramas",
                            posterList: _tenseDramas,
                          ),
                          MainTitleCard(
                            title: "South Indian Cinima",
                            posterList: _southIndian,
                          ),
                        ],
                      );
                    }
                  }),
                  scrollNotifier.value == true
                      ? AnimatedContainer(
                          duration: Duration(milliseconds: 1000),
                          width: double.infinity,
                          height: 80,
                          color: Colors.black.withOpacity(0.3),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      "https://w7.pngwing.com/pngs/280/326/png-transparent-logo-netflix-logos-and-brands-icon-thumbnail.png",
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.cast,
                                    color: iconColor,
                                  ),
                                  kWidth,
                                  Container(
                                    width: 25,
                                    height: 25,
                                    color: Colors.blue,
                                  ),
                                  kWidth,
                                ],
                              ),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'TV Shows',
                                    style: kHomeTitleText,
                                  ),
                                  Text(
                                    'Movies',
                                    style: kHomeTitleText,
                                  ),
                                  Text(
                                    'Categories',
                                    style: kHomeTitleText,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : kHeight,
                ],
              ),
            );
          }),
    );
  }
}
