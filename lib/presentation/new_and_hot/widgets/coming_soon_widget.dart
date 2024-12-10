import 'package:flutter/material.dart';
import 'package:netflix_app/core/constants/constants.dart';
import 'package:netflix_app/presentation/home/widgets/custom_button_widget.dart';

import '../../../core/colors/colors.dart';

class ComingSoonWidget extends StatelessWidget {
  final String month;
  final String day;
  final String image;
  final String title;
  final String comingDate;
  final String description;

  const ComingSoonWidget({
    Key? key,
    required this.month,
    required this.day,
    required this.image,
    required this.title,
    required this.comingDate,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                month,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                day,
                style: const TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 500,
          width: size.width - 50,
          child: Column(
            children: [
              videoWidget(size: size, image: image),
              SizedBox(
                width: size.width - 50,
                height: 300,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              letterSpacing: -5,
                            ),
                          ),
                        ),
                        //const Spacer(),

                        const CustomButtonWidget(
                          text: 'Remind Me',
                          icon: Icons.notification_add,
                          iconSize: 20,
                          textSize: 12,
                        ),
                        kWidth,
                        const CustomButtonWidget(
                          text: 'Info',
                          icon: Icons.info,
                          iconSize: 20,
                          textSize: 12,
                        ),
                      ],
                    ),
                    Text(
                      'Coming On $comingDate',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    kHeight,
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    kHeight,
                    Expanded(
                      child: Text(
                        description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: const TextStyle(
                          color: textThemeColor3,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class videoWidget extends StatelessWidget {
  const videoWidget({
    super.key,
    required this.size,
    required this.image,
  });

  final Size size;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: size.width - 50,
      child: Stack(
        children: [
          Image.network(
            image,
            fit: BoxFit.cover,
            width: double.infinity,
            loadingBuilder:
                (BuildContext _, Widget child, ImageChunkEvent? progress) {
              if (progress == null) {
                return child;
              } else {
                return const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                );
              }
            },
            errorBuilder: (BuildContext _, Object a, StackTrace? trace) {
              return const Center(
                  child: Icon(
                Icons.wifi,
                color: Colors.red,
              ));
            },
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: CircleAvatar(
              radius: 18,
              backgroundColor: Colors.black.withOpacity(0.7),
              child: const Icon(
                Icons.volume_off_rounded,
                color: iconColor,
                size: 18,
              ),
            ),
          )
        ],
      ),
    );
  }
}
