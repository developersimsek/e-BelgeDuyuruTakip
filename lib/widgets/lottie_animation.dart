import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimationWidget extends StatefulWidget {
  const LottieAnimationWidget(
      {super.key,
      required this.animationPath,
      this.width = 200,
      this.height = 200});

  final String animationPath;
  final double width;
  final double height;

  @override
  State<LottieAnimationWidget> createState() => _LottieAnimationWidgetState();
}

class _LottieAnimationWidgetState extends State<LottieAnimationWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationPath.isEmpty) {
      return Container();
    }
    return Lottie.asset(widget.animationPath,
        width: widget.width,
        height: widget.height,
        repeat: true,
        reverse: true);
  }
}