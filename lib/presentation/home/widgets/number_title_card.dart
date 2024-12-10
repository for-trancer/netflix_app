import 'package:flutter/material.dart';
import 'package:netflix_app/core/constants/constants.dart';
import 'package:netflix_app/core/constants/strings.dart';
import 'package:netflix_app/presentation/home/widgets/number_card.dart';
import 'package:netflix_app/presentation/widgets/main_title.dart';

class NumberTitleCard extends StatelessWidget {
  final String title;
  final List<String> postersList;
  const NumberTitleCard(
      {super.key, required this.postersList, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MainTitle(title: title),
          kHeight,
          LimitedBox(
            maxHeight: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(
                postersList.length,
                (index) => NumberCard(
                  imageUrl: '$imageUrl${postersList[index]}',
                  index: index + 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
