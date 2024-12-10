import 'package:flutter/material.dart';
import 'package:netflix_app/core/constants/constants.dart';
import 'package:netflix_app/presentation/widgets/main_card.dart';
import 'package:netflix_app/presentation/widgets/main_title.dart';

class MainTitleCard extends StatelessWidget {
  final String title;
  final List<String> posterList;

  const MainTitleCard({
    required this.posterList,
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                posterList.length,
                (index) => MainCard(
                  imageUrl: posterList[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
