import 'package:flutter/material.dart';

class WaterContainer extends StatefulWidget {
  @override
  _WaterContainerState createState() => _WaterContainerState();
}

class _WaterContainerState extends State<WaterContainer> {
  double _waterLevel = 0.5; // Initial water level (50%)

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          // Adjust the water level based on the drag distance
          _waterLevel += details.primaryDelta! / w;
          // Ensure the water level remains within 0.0 to 1.0
          _waterLevel = _waterLevel.clamp(0.0, 1.0);
        });
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5), // Circular border
        child: Container(
          height: h * 0.08,
          width: w * 0.9,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Stack(
            children: [
              Container(
                height: h * 0.08,
                width: w * 0.9 * _waterLevel,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Positioned(
                left: 8,
                top: 8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Water Level', style: TextStyle(fontSize: 16, color: Colors.white)),
                    SizedBox(height: 4),
                    Text('${(_waterLevel * 100).toStringAsFixed(1)}%', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
