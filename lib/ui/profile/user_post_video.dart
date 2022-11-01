import 'package:analysist/core/colors.dart';
import 'package:analysist/widgets/loading_widget.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../core/math_utils.dart';

class UserPostVideo extends StatefulWidget {
  String displayUrl;
  String videoUrl;
  UserPostVideo({Key? key, required this.videoUrl, required this.displayUrl})
      : super(key: key);

  @override
  State<UserPostVideo> createState() => _UserPostVideoState();
}

class _UserPostVideoState extends State<UserPostVideo> {
  @override
  void initState() {
    super.initState();
    init();
  }

  static VideoPlayerController? videoPlayerController;

  init() async {
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    await videoPlayerController!.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController!,
      autoPlay: true,
      looping: true,
    );
    setState(() {});
  }

  var chewieController;

  @override
  void dispose() {
    videoPlayerController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (videoPlayerController!.value.isInitialized) {
      return Center(
        child: AspectRatio(
          aspectRatio: videoPlayerController!.value.aspectRatio,
          child: Chewie(
            controller: chewieController,
          ),
        ),
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(
                    widget.displayUrl,
                  ))),
        ),
        loading(ColorManager.secondary, 200)
      ],
    );
  }
}
