import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomStaticThumbShape extends SliderComponentShape {
  static const double _thumbWidth = 50.0; // ✅ Oval width
  static const double _thumbHeight = 28.0; // ✅ Oval height

  final double staticValue; // ✅ Static value (e.g., 827)

  CustomStaticThumbShape(this.staticValue);

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(_thumbWidth, _thumbHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    // ✅ Paint for the oval thumb
    final Paint thumbPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    // ✅ Draw the oval thumb shape
    final RRect thumbRect = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: _thumbWidth,
        height: _thumbHeight,
      ),
      const Radius.circular(12), // ✅ Oval shape with rounded corners
    );

    canvas.drawRRect(thumbRect, thumbPaint); // Fill
    canvas.drawRRect(thumbRect, borderPaint); // Border

    // ✅ Draw the static value inside the oval
    final TextSpan span = TextSpan(
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      text: staticValue.toInt().toString(),
    );

    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();
    tp.paint(
      canvas,
      Offset(
        center.dx - (tp.width / 2),
        center.dy - (tp.height / 2),
      ),
    );
  }
}

class CustomRangeThumbShape extends RangeSliderThumbShape {
  static const double _thumbSize = 48.0;
  final double min;
  final double max;

  const CustomRangeThumbShape({
    required this.min,
    required this.max,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size(_thumbSize, _thumbSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = true,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;

    // Define the thumb’s fill paint.
    final Paint fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Define the thumb’s border paint.
    final Paint borderPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Create the thumb rectangle.
    final RRect thumbRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: _thumbSize, height: 20),
      const Radius.circular(10),
    );

    // Draw the filled rectangle and then the border.
    canvas.drawRRect(thumbRect, fillPaint);
    canvas.drawRRect(thumbRect, borderPaint);

    // Determine which value to display based on the thumb.
    int displayText;
    if (thumb == Thumb.start) {
      displayText = min.toInt();
    } else if (thumb == Thumb.end) {
      displayText = max.toInt();
    } else {
      displayText = 400;
    }

    // Prepare the text style and painter.
    final TextSpan span = TextSpan(
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      text: '$displayText',
    );

    final TextPainter tp = TextPainter(
      text: span,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    tp.layout();

    // Center the text within the thumb.
    tp.paint(
      canvas,
      Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2)),
    );
  }
}
