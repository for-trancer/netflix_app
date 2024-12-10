import 'package:flutter/material.dart';

import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants/constants.dart';
import 'package:netflix_app/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix_app/presentation/new_and_hot/widgets/coming_soon_widget.dart';

class everyonesWatchingWidget extends StatelessWidget {
  final String title;
  final String describtion;
  final String image;
  const everyonesWatchingWidget({
    Key? key,
    required this.title,
    required this.describtion,
    required this.image,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight,
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.clip,
          ),
          maxLines: 1,
        ),
        kHeight,
        Text(
          describtion,
          style: const TextStyle(
            color: textThemeColor3,
            fontSize: 14,
            overflow: TextOverflow.clip,
          ),
          maxLines: 4,
        ),
        kHeight50,
        SizedBox(
          width: size.width - 10,
          child: videoWidget(size: size, image: image),
        ),
        kHeight,
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonWidget(
              text: 'Share',
              icon: Icons.share,
              iconSize: 30,
              textSize: 12,
            ),
            kWidth,
            CustomButtonWidget(
              text: 'My List',
              icon: Icons.add,
              iconSize: 30,
              textSize: 12,
            ),
            kWidth,
            CustomButtonWidget(
              text: 'Play',
              icon: Icons.play_arrow,
              iconSize: 30,
              textSize: 12,
            ),
            kWidth,
          ],
        ),
      ],
    );
  }
}
