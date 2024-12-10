import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/search/search_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants/constants.dart';
import 'package:netflix_app/core/constants/strings.dart';
import 'package:netflix_app/presentation/search/widgets/title.dart';

class ScreenIdleWidget extends StatelessWidget {
  const ScreenIdleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Top Searches'),
        kHeight,
        Expanded(
          child: BlocBuilder<SearchBloc, SearchState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state.isError) {
                return const Center(
                  child: Text('Error While Getting Data'),
                );
              } else if (state.idleList.isEmpty) {
                return const Center(
                  child: Text('List Is Empty'),
                );
              } else {
                return ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      final movie = state.idleList[index];
                      return TopSearchItemTile(
                          title: movie.title ?? 'No Title',
                          imageUrl: '$imageUrl${movie.posterPath}');
                    },
                    separatorBuilder: (ctx, index) => kHeight20,
                    itemCount: state.idleList.length);
              }
            },
          ),
        )
      ],
    );
  }
}

class TopSearchItemTile extends StatelessWidget {
  final String title;
  final String imageUrl;
  const TopSearchItemTile({
    super.key,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          width: screenWidth * 0.35,
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                imageUrl,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: textThemeColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const CircleAvatar(
          backgroundColor: iconColor,
          radius: 25,
          child: CircleAvatar(
            backgroundColor: iconColor2,
            radius: 23,
            child: Icon(
              CupertinoIcons.play_fill,
              color: iconColor,
            ),
          ),
        ),
      ],
    );
  }
}
