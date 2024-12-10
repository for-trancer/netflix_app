import 'package:flutter/material.dart';
import 'package:netflix_app/core/constants/constants.dart';

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({
    required this.imageUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.27,
      height: size.width * 0.5,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: kRadius,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            imageUrl,
          ),
        ),
      ),
    );
  }
}
