// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:netflix_app/application/fast_laugh/fast_laugh_bloc.dart';
import 'package:netflix_app/core/colors/colors.dart';
import 'package:netflix_app/core/constants/strings.dart';
import 'package:video_player/video_player.dart';
import 'package:netflix_app/domain/downloads/models/downloads.dart';

class VideoListItemInheritedWidget extends InheritedWidget {
  final Widget widget;
  final Downloads movieData;

  const VideoListItemInheritedWidget({
    super.key,
    required this.widget,
    required this.movieData,
  }) : super(child: widget);

  @override
  bool updateShouldNotify(covariant VideoListItemInheritedWidget oldWidget) {
    return oldWidget.movieData != movieData;
  }

  static VideoListItemInheritedWidget? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoListItemInheritedWidget>();
  }
}

class VideoListItem extends StatelessWidget {
  final int index;
  const VideoListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final videoUrl = dummyVideoUrls[index % dummyVideoUrls.length];
    final posterPath =
        VideoListItemInheritedWidget.of(context)?.movieData.posterPath;
    return Stack(
      children: [
        FastLaughVideoPlayer(videourl: videoUrl, onStateChanged: (bool) {}),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// left side
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black.withOpacity(0.5),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.volume_off,
                      color: iconColor,
                      size: 30,
                    ),
                  ),
                ),

                /// right side
                Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: posterPath == null
                          ? null
                          : NetworkImage('$imageUrl$posterPath'),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: likedVideosIdsNotifier,
                    builder:
                        (BuildContext c, Set<int> newLikedListIds, Widget? _) {
                      final _index = index;
                      if (newLikedListIds.contains(_index)) {
                        return GestureDetector(
                          onTap: () {
                            //BlocProvider.of<FastLaughBloc>(context)
                            //  .add(UnlikeVideo(id: _index));
                            likedVideosIdsNotifier.value.remove(_index);
                            likedVideosIdsNotifier.notifyListeners();
                          },
                          child: const VideoActionsWidget(
                              icon: Icons.favorite_outline, title: 'Liked'),
                        );
                      } else {
                        return GestureDetector(
                          onTap: () {
                            //BlocProvider.of<FastLaughBloc>(context)
                            // .add(LikeVideo(id: _index));
                            likedVideosIdsNotifier.value.add(_index);
                            likedVideosIdsNotifier.notifyListeners();
                          },
                          child: const VideoActionsWidget(
                              icon: Icons.emoji_emotions, title: 'LOL'),
                        );
                      }
                    },
                  ),
                  const VideoActionsWidget(
                    icon: Icons.add,
                    title: 'My List',
                  ),
                  GestureDetector(
                    child: const VideoActionsWidget(
                        icon: Icons.share, title: 'Share'),
                    onTap: () async {
                      final movieName = VideoListItemInheritedWidget.of(context)
                          ?.movieData
                          .posterPath;
                      if (movieName != null) {
                        log(movieName.toString());
                      }
                    },
                  ),
                  const VideoActionsWidget(
                      icon: Icons.play_arrow, title: 'Play'),
                ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class VideoActionsWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const VideoActionsWidget(
      {super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          Icon(
            icon,
            color: iconColor,
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class FastLaughVideoPlayer extends StatefulWidget {
  final String videourl;
  final void Function(bool isPlaying) onStateChanged;
  const FastLaughVideoPlayer(
      {super.key, required this.videourl, required this.onStateChanged});

  @override
  State<FastLaughVideoPlayer> createState() => _FastLaughVideoPlayerState();
}

class _FastLaughVideoPlayerState extends State<FastLaughVideoPlayer> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videourl);
    _videoPlayerController.initialize().then((value) {
      setState(() {
        _videoPlayerController.play();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: _videoPlayerController.value.isInitialized
          ? AspectRatio(
              aspectRatio: _videoPlayerController.value.aspectRatio,
              child: VideoPlayer(_videoPlayerController),
            )
          : const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }
}
