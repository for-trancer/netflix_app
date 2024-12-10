import 'package:flutter/material.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants/constants.dart';
import 'package:netflix_app/presentation/home/widgets/custom_button_widget.dart';

class BackgroundCard extends StatelessWidget {
  const BackgroundCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 850,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                kMainImage,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const CustomButtonWidget(text: "My List", icon: Icons.add),
              _PlayButton(),
              const CustomButtonWidget(text: "Info", icon: Icons.info),
            ],
          ),
        )
      ],
    );
  }

  TextButton _PlayButton() {
    return TextButton.icon(
      onPressed: () {},
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(textThemeColor),
      ),
      icon: const Icon(
        Icons.play_arrow,
        size: 25,
        color: iconColor2,
      ),
      label: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          'Play',
          style: TextStyle(color: textThemeColor2, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
