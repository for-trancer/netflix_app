import 'package:bordered_text/bordered_text.dart';
import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants/constants.dart';

class NumberCard extends StatelessWidget {
  final int index;
  final String imageUrl;
  const NumberCard({super.key, required this.index, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Row(
          children: [
            SizedBox(
              width: 30,
              height: size.width * 0.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: size.width * 0.27,
                height: size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: kRadius,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      imageUrl,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 10,
          bottom: -48,
          child: BorderedText(
            strokeWidth: 4,
            strokeColor: textThemeColor,
            child: Text(
              index.toString(),
              style: const TextStyle(
                fontSize: 150,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                color: textThemeColor2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
