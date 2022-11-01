import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottiePage extends StatefulWidget {
  double width;
  double heigth;
  String lottie;
  LottiePage({required this.width, required this.heigth, required this.lottie});

  @override
  _LottiePageState createState() => _LottiePageState();
}

class _LottiePageState extends State<LottiePage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  int randomToy = 1;
  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.animateTo(0.0).then((value) => _controller.forward());
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: Lottie.asset(
        'assets/lotties/${widget.lottie}.json',
        width: widget.width,
        height: widget.heigth,
        fit: BoxFit.contain,
        controller: _controller,
        onLoaded: (composition) {
          // Configure the AnimationController with the duration of the
          // Lottie file and start the animation.

          _controller
            ..duration = composition.duration
            ..forward();
        },
      ),
    );
  }
}
