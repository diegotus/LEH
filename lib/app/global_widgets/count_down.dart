import 'package:flutter/material.dart';

class CountDownWidget extends StatefulWidget {
  const CountDownWidget(
      {super.key,
      required this.title,
      required this.duration,
      this.style,
      this.onDone,
      this.inBox = false,
      this.animationBuilder});
  final bool inBox;
  final Duration duration;
  final String title;
  final TextStyle? style;
  final CountDownAnimationBuilder Function(
      Animation<int> animation, TextStyle? style)? animationBuilder;
  final Function()? onDone;

  @override
  CountDownWidgetState createState() => CountDownWidgetState();
}

class CountDownWidgetState extends State<CountDownWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  int get levelClock => widget.duration.inSeconds;

  @override
  void dispose() {
    _controller.removeListener(listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: Duration(
          seconds: levelClock,
        ) // gameData.levelClock is a user entered number elsewhere in the applciation
        );

    _controller.forward();
    _controller.addListener(listener);
  }

  void listener() {
    if (widget.onDone != null && _controller.isCompleted ||
        _controller.isDismissed) {
      widget.onDone!();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animationBuilder != null) {
      return widget.animationBuilder!(
        StepTween(
          begin: levelClock, // THIS IS A USER ENTERED NUMBER
          end: 0,
        ).animate(_controller),
        widget.style,
      );
    }
    return _Countdown(
      style: widget.style,
      animation: StepTween(
        begin: levelClock, // THIS IS A USER ENTERED NUMBER
        end: 0,
      ).animate(_controller),
    );
  }
}

abstract class CountDownAnimationBuilder extends AnimatedWidget {
  const CountDownAnimationBuilder({
    super.key,
    required this.animation,
    this.style,
  }) : super(listenable: animation);
  final Animation<int> animation;
  final TextStyle? style;
  @override
  Widget build(BuildContext context);
}

class _Countdown extends CountDownAnimationBuilder {
  const _Countdown({required super.animation, super.style});

  @override
  build(BuildContext context) {
    Duration clockTimer = Duration(seconds: animation.value);

    String timerText =
        '${clockTimer.inMinutes.remainder(60).toString()}:${clockTimer.inSeconds.remainder(60).toString().padLeft(2, '0')}';

    return Text(
      timerText,
      style: style,
    );
  }
}
