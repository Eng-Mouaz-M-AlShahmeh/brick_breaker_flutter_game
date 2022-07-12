/* Developed by Eng Mouaz M AlShahmeh */
import 'dart:math';
import 'package:brick_breaker_flutter_game/base/style/color_extension.dart';
import 'package:brick_breaker_flutter_game/base/style/colors.dart';
import 'package:flutter/material.dart';

class Bubbles extends StatefulWidget {
  final int numberOfBubbles;
  final double maxBubbleSize;

  const Bubbles(
      {Key? key, required this.numberOfBubbles, required this.maxBubbleSize})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BubblesState();
  }
}

class _BubblesState extends State<Bubbles> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Bubble> bubbles;

  @override
  void initState() {
    super.initState();

    // Initialize bubbles
    List<Color> color = [
      AppColors.blueColor,
      AppColors.bubbleRedColor,
      AppColors.bubbleYellowColor
    ];

    bubbles = [];
    int i = widget.numberOfBubbles;
    int j = 0;
    while (i > 0) {
      bubbles.add(Bubble(color[j], widget.maxBubbleSize));
      i--;
      j++;
      if (j > 2) j = 0;
    }

    // Init animation controller
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    _controller.addListener(() {
      updateBubblePosition();
    });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.bubbleBackgroundColor,
      body: CustomPaint(
        foregroundPainter: BubblePainter(bubbles: bubbles),
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
      ),
    );
  }

  void updateBubblePosition() {
    for (var it in bubbles) {
      it.updatePosition();
    }
    setState(() {});
  }
}

class BubblePainter extends CustomPainter {
  List<Bubble> bubbles;

  BubblePainter({required this.bubbles});

  @override
  void paint(Canvas canvas, Size size) {
    for (var it in bubbles) {
      it.draw(canvas, size);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Bubble {
  late Color colour;
  late double direction;
  late double speed;
  late double radius;
  double? x;

  double? y;

  Bubble(Color colour, double maxBubbleSize) {
    this.colour = colour.withOpacity(Random().nextDouble());
    direction = Random().nextDouble() * 360;
    speed = 1;
    radius = Random().nextDouble() * maxBubbleSize;
  }

  draw(Canvas canvas, Size canvasSize) {
    Paint paint = Paint()
      ..color = colour
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill;

    assignRandomPositionIfUninitialized(canvasSize);

    randomlyChangeDirectionIfEdgeReached(canvasSize);

    canvas.drawCircle(Offset(x ?? 0, y ?? 0), radius, paint);
  }

  void assignRandomPositionIfUninitialized(Size canvasSize) {
    x ??= Random().nextDouble() * canvasSize.width;
    y ??= Random().nextDouble() * canvasSize.height;
  }

  // ignore: curly_braces_in_flow_control_structures
  updatePosition() {
    var a = 180 - (direction + 90);
    if (x != null && direction > 0 && direction < 180) {
      x = x! + speed * sin(direction) / sin(speed);
    } else if (x != null) {
      x = x! - speed * sin(direction) / sin(speed);
    }
    if (y != null && direction > 90 && direction < 270) {
      y = y! + speed * sin(a) / sin(speed);
    } else if (y != null) {
      y = y! - speed * sin(a) / sin(speed);
    }
  }

  randomlyChangeDirectionIfEdgeReached(Size canvasSize) {
    if ((x != null && y != null) &&
        (x! > canvasSize.width || x! < 0 || y! > canvasSize.height || y! < 0)) {
      direction = Random().nextDouble() * 360;
    }
  }
}
