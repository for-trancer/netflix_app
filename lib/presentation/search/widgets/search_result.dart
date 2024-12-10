import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/search/search_bloc.dart';
import 'package:netflix_app/core/constants/constants.dart';
import 'package:netflix_app/core/constants/strings.dart';
import 'package:netflix_app/presentation/search/widgets/title.dart';

class SearchResultWidget extends StatelessWidget {
  const SearchResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SearchTextTitle(title: 'Movies & TV'),
        kHeight,
        BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Expanded(
                child: GridView.count(
              shrinkWrap: true,
              crossAxisCount: 3,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 1 / 1.4,
              children: List.generate(state.searchResultList.length, (index) {
                final movie = state.searchResultList[index];
                return MainCard(imUrl: movie.posterPath);
              }),
            ));
          },
        )
      ],
    );
  }
}

class MainCard extends StatelessWidget {
  final String? imUrl;
  const MainCard({super.key, required this.imUrl});
  @override
  Widget build(BuildContext context) {
    final String imgUrl = '$imageUrl$imUrl';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        image: DecorationImage(
          image: NetworkImage(imgUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
