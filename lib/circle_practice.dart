import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class SleekSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sleek Slider'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300, // Size of the circular slider
              height: 300,
              child: SleekCircularSlider(
                appearance: CircularSliderAppearance(
                  customWidths: CustomSliderWidths(
                    trackWidth: 12.0, // Width of the track
                    progressBarWidth: 8.0, // Width of the progress bar
                    // handlerWidth: 15.0, // Width of the handler
                  ),
                  customColors: CustomSliderColors(
                    trackColor: Colors.grey[300],
                    progressBarColors: [Colors.lightGreen, Colors.amberAccent],
                    dotColor: Colors.orange,
                    shadowColor: Colors.grey.withOpacity(0.5),
                  ),
                  size: 300, // Size of the circular slider
                  startAngle: 270,
                  angleRange: 360,
                  infoProperties: InfoProperties(
                    topLabelText: 'Part Size',
                    topLabelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    mainLabelStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    bottomLabelText: 'Between Labels',
                  ),
                ),
                initialValue: 0,
                onChange: (double value) {
                  print(value);
                },
                innerWidget: (double value) {
                  // Display the part size in the center
                  return Center(
                    child: Text(
                      '${(value / 24).toStringAsFixed(2)}', // Display value divided by 24
                      style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
