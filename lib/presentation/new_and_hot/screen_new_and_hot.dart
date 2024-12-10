import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix_app/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants/constants.dart';
import 'package:netflix_app/core/constants/strings.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/everyones_watching_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            title: const Text(
              "New & Hot",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: textThemeColor,
              ),
            ),
            actions: [
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
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: TabBar(
                dividerColor: Colors.black,
                unselectedLabelColor: textThemeColor,
                labelColor: textThemeColor2,
                labelStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                indicator: BoxDecoration(
                  color: iconColor,
                  borderRadius: kRadius30,
                ),
                tabs: const [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("😊 Coming Soon"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("👀 Everyone's Watching"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            ComingSoonList(key: Key('coming_soon')),
            EveryonesWatchingList(key: Key('everyones_watching')),
          ],
        ),
      ),
    );
  }
}

class EveryonesWatchingList extends StatelessWidget {
  const EveryonesWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
    });
    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          BlocProvider.of<HotAndNewBloc>(context)
              .add(const LoadDataInEveryoneIsWatching());
        });
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(
              child: Text('Error Loading Everyone Is Watching List'),
            );
          } else if (state.everyoneIsWatchingList.isEmpty) {
            return const Center(
              child: Text('The List Is Empty'),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: state.everyoneIsWatchingList.length,
                itemBuilder: (BuildContext context, index) {
                  final tv = state.everyoneIsWatchingList[index];
                  return everyonesWatchingWidget(
                    size: size,
                    title: tv.originalName!,
                    image: '$imageUrl${tv.posterPath}',
                    describtion: tv.overview!,
                  );
                });
          }
        },
      ),
    );
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          BlocProvider.of<HotAndNewBloc>(context)
              .add(const LoadDataInComingSoon());
        });
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(
              child: Text('Error Loading Coming Soon List'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('The List Is Empty'),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemCount: state.comingSoonList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.comingSoonList[index];
                  final _date = DateTime.parse(movie.releaseDate!);
                  final formattedDate =
                      DateFormat.yMMMMd('en_US').format(_date);
                  final month = formattedDate
                      .split(' ')
                      .first
                      .substring(0, 3)
                      .toUpperCase();
                  final day = movie.releaseDate!.split('-')[1];

                  return ComingSoonWidget(
                    month: month,
                    day: day,
                    image: '$imageUrl${movie.posterPath}',
                    title: movie.originalTitle ?? 'No Title',
                    comingDate: '$month $day',
                    description: movie.overview ?? 'No Overview',
                  );
                });
          }
        },
      ),
    );
  }
}
