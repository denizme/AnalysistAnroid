import 'package:flutter/material.dart';
import 'package:analysist/core/colors.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:loading_progress_indicator/loading_progress_indicator.dart';
import 'package:loading_progress_indicator/progress_indicator/ball_scale_multiple_progress_indicator.dart';

Widget loading([Color? color, double? size]) {
  return Center(
      child: LoadingAnimationWidget.fallingDot(
    color: color ?? ColorManager.secondary,
    size: size ?? 50,
  ));
}
