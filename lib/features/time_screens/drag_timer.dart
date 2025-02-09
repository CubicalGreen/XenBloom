import 'dart:math';
import 'package:flutter/material.dart';
import '../authentication_screens/globalVariable.dart';

class CircularDragTimerWidget extends StatefulWidget {
  final Function(double, double) onTimeChanged;

  const CircularDragTimerWidget({
    Key? key,
    required this.onTimeChanged,
  }) : super(key: key);

  @override
  _CircularDragTimerWidgetState createState() =>
      _CircularDragTimerWidgetState();
}

class _CircularDragTimerWidgetState extends State<CircularDragTimerWidget> {
  double _startProgress = 0.75;
  double _endProgress = 0.25;
  bool _showStartLabel = false;
  bool _showEndLabel = false;

  @override
  void initState() {
    super.initState();
    _startProgress = globalStartHour / 24;
    _endProgress = globalEndHour / 24;
  }

  int get _cycles {
    final progressDiff = (_endProgress - _startProgress + 1) % 1;
    return (progressDiff * 24).round(); // Ensure cycles are always integers
  }

  void _handleDrag(Offset localPosition) {
    final center = Offset(150, 150);
    final angle =
        atan2(localPosition.dy - center.dy, localPosition.dx - center.dx) +
            pi / 2;

    double newProgress = angle / (2 * pi);
    if (newProgress < 0) newProgress += 1;

    // Snap to 30-minute intervals (1/48th of a full cycle)
    newProgress = (newProgress * 48).round() / 48.0;

    setState(() {
      final startAngle = 2 * pi * _startProgress;
      final endAngle = 2 * pi * _endProgress;

      final startDistance = _distanceToArc(angle, startAngle);
      final endDistance = _distanceToArc(angle, endAngle);

      if (startDistance < endDistance) {
        _startProgress = newProgress;
        _showStartLabel = true;
      } else {
        _endProgress = newProgress;
        _showEndLabel = true;
      }

      // Convert progress to hours and minutes
      globalStartHour = (_startProgress * 24).toInt();
      globalStartMinute = ((_startProgress * 1440) % 60).toInt();

      globalEndHour = (_endProgress * 24).toInt();
      globalEndMinute = ((_endProgress * 1440) % 60).toInt();

      widget.onTimeChanged(
        globalStartHour.toDouble(),
        globalEndHour.toDouble(),
      );
    });
  }

  double _distanceToArc(double angle, double arcAngle) {
    final diff = (angle - arcAngle).abs();
    return min(diff, 2 * pi - diff);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: GestureDetector(
        onPanUpdate: (details) => _handleDrag(details.localPosition),
        onTap: () {
          setState(() {
            _showStartLabel = true;
            _showEndLabel = true;
          });
        },
        child: Stack(
          children: [
            CustomPaint(
              painter: CircularTimerPainter(
                startProgress: _startProgress,
                endProgress: _endProgress,
              ),
              child: Center(
                child: Text(
                  "${_cycles} Cycles", // ✅ Ensure cycles are always integers
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            _buildLabel(_startProgress, _showStartLabel, true), // Start label
            _buildLabel(_endProgress, _showEndLabel, false), // End label
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(double progress, bool showLabel, bool isStart) {
    if (!showLabel) return SizedBox(); // Hide label if not needed

    double angle = 2 * pi * progress - pi / 2;
    double radius = 130; // Distance from center
    Offset position = Offset(
      150 + radius * cos(angle),
      150 + radius * sin(angle),
    );

    int hour = (progress * 24).toInt();
    int minute = ((progress * 1440) % 60).toInt();

    return Positioned(
      left: position.dx - 25,
      top: position.dy - 40,
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isStart) {
              _showStartLabel = !_showStartLabel;
            } else {
              _showEndLabel = !_showEndLabel;
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class CircularTimerPainter extends CustomPainter {
  final double startProgress;
  final double endProgress;

  CircularTimerPainter({
    required this.startProgress,
    required this.endProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint basePaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15;

    final Paint progressPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    // Draw base circle
    canvas.drawCircle(center, radius, basePaint);

    // Draw progress arc
    final startAngle = 2 * pi * startProgress - pi / 2;
    final sweepAngle = 2 * pi * ((endProgress - startProgress + 1) % 1);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
