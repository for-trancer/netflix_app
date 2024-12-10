import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix_app/application/downloads/downloads_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants/constants.dart';
import 'package:netflix_app/core/constants/strings.dart';
import 'package:netflix_app/presentation/widgets/app_bar_widget.dart';

class ScreenDownloads extends StatelessWidget {
  ScreenDownloads({super.key});

  final _widgetList = [
    _SmartDownloads(),
    Section2(),
    const Section3(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBarWidget(title: 'Downloads'),
      ),
      body: ListView.separated(
          padding: const EdgeInsets.all(10),
          itemBuilder: (ctx, index) => _widgetList[index],
          separatorBuilder: (ctx, index) => const SizedBox(height: 25),
          itemCount: _widgetList.length),
    );
  }
}

class Section2 extends StatelessWidget {
  Section2({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      BlocProvider.of<DownloadsBloc>(context)
          .add(const DownloadsEvent.getDownloadsImage());
    });
    return Column(
      children: [
        const Text(
          "Introducing Downloads For You",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: textThemeColor,
          ),
          textAlign: TextAlign.center,
        ),
        kHeight,
        const Text(
          "We'll download a personalised selection of\n movies and shows for you,so there's\n always something to watch on your \ndevice.",
          style: TextStyle(
            fontSize: 16,
            color: textGreyColor,
          ),
          textAlign: TextAlign.center,
        ),
        BlocBuilder<DownloadsBloc, DownloadsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              );
            } else if (state.downloads.isEmpty) {
              return const Center(
                child: Text('The Download List Is Empty!'),
              );
            } else {
              return SizedBox(
                width: size.width,
                height: size.width,
                child: state.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          CircleAvatar(
                            radius: size.width * 0.35,
                            backgroundColor: circleAvatarColor.withOpacity(0.5),
                          ),
                          DownloadsImageWidget(
                            size: Size(size.width * 0.38, size.width * 0.42),
                            image: '$imageUrl${state.downloads[0].posterPath}',
                            margin: const EdgeInsets.only(left: 190, top: 25),
                            angle: 30,
                          ),
                          DownloadsImageWidget(
                              size: Size(size.width * 0.38, size.width * 0.42),
                              image:
                                  '$imageUrl${state.downloads[1].posterPath}',
                              margin:
                                  const EdgeInsets.only(right: 190, top: 25),
                              angle: -30),
                          DownloadsImageWidget(
                            size: Size(size.width * 0.4, size.width * 0.55),
                            image: '$imageUrl${state.downloads[2].posterPath}',
                            margin: const EdgeInsets.only(),
                          )
                        ],
                      ),
              );
            }
          },
        ),
      ],
    );
  }
}

class Section3 extends StatelessWidget {
  const Section3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              onPressed: () {},
              color: buttonColorPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  "Set up",
                  style: TextStyle(
                    color: textThemeColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        kHeight,
        MaterialButton(
          onPressed: () {},
          color: buttonColorSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "See What You Can Download",
              style: TextStyle(
                color: textThemeColor2,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }
}

class _SmartDownloads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        kWidth,
        Icon(
          Icons.settings,
          color: iconColor,
        ),
        kWidth,
        Text(
          "Smart Downloads",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        )
      ],
    );
  }
}

class DownloadsImageWidget extends StatelessWidget {
  const DownloadsImageWidget({
    super.key,
    required this.size,
    required this.image,
    this.angle = 0,
    required this.margin,
  });

  final Size size;
  final String image;
  final double angle;
  final EdgeInsets margin;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Transform.rotate(
        angle: angle * pi / 180,
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: NetworkImage(
                image,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
