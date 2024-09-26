import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:ui';

class timeUpdateWidget extends StatefulWidget {
  const timeUpdateWidget({super.key});

  @override
  State<timeUpdateWidget> createState() => _timeUpdateWidgetState();
}

class _timeUpdateWidgetState extends State<timeUpdateWidget> {
  void _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Make background transparent
      builder: (context) {
        return Stack(
          children: [
            // The grey and blurry background that covers the entire screen
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 2.0, sigmaY: 2.0), // Apply blur effect
                child: Container(
                  color: Color(0xFF494e52)
                      .withOpacity(0.5), // Grey color with opacity
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0, right: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.white,
                    size: 30,
                  ), // Down arrow icon
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                ),
              ),
            ),
            // The original bottom sheet UI, placed at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height *
                    0.63, // Reduced height of the bottom sheet
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Align the text to the left
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left:
                                    20.0), // Add padding to keep it away from the edge
                            child: Text(
                              'Water Regulation Cycle',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.03),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.03),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TwoSidedSliderGauge()
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0, right: 14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.03),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Image.asset(
                                              'assets/images/water_drops_bold.png', // Replace with your image path
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                              color: Colors.grey[
                                                  400], // Apply the same color as the icon
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0075),
                                      Row(
                                        children: [
                                          Text(
                                            '02:00',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Transform.translate(
                                                    offset: Offset(
                                                        0,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01), // Adjust the offset for subscript effect
                                                    child: Text(
                                                      ' Mins', // Subscript text
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        color: Colors.grey[800],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              Expanded(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.03),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Image.asset(
                                              'assets/images/time_clock.png', // Replace with your image path
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.07,
                                              color: Colors.grey[
                                                  400], // Apply the same color as the icon
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.0075),
                                      Row(
                                        children: [
                                          Text(
                                            '01:00',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Transform.translate(
                                                    offset: Offset(
                                                        0,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01), // Adjust the offset for subscript effect
                                                    child: Text(
                                                      ' Hrs', // Subscript text
                                                      style: TextStyle(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        color: Colors.grey[800],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Handle Cancel button press
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, // Button color
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.44,
                                      50), // Increase size
                                  textStyle: TextStyle(
                                    fontSize: 18, // Increase text size
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Reduced border radius
                                  ),
                                ),
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black, // Button color
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.44,
                                      50), // Increase size
                                  textStyle: TextStyle(
                                    fontSize: 18, // Increase text size
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Reduced border radius
                                  ),
                                ),
                                child: Text(
                                  'Reset',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => _showBottomSheet(),
      child: Container(
        height: h * 0.17,
        padding:
            EdgeInsets.only(top: h * 0.068, left: w * 0.04, right: w * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Next Cycle in',
                style: TextStyle(fontSize: 20),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '28:42',
                    style: TextStyle(fontSize: 35),
                  ),
                  SizedBox(width: 4),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'mins',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TwoSidedSliderGauge extends StatefulWidget {
  @override
  _TwoSidedSliderGaugeState createState() => _TwoSidedSliderGaugeState();
}

class _TwoSidedSliderGaugeState extends State<TwoSidedSliderGauge> {
  double _startValue = 2; // Example initial start value
  double _endValue = 8;   // Example initial end value

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 290,
        height: 290,
        child: SfRadialGauge(
          
          axes: <RadialAxis>[
            RadialAxis(
              minimum: 0,
              maximum: 24,
              interval: 1,
              startAngle: 270, // Start at the top
              endAngle: 630,   // Complete circle (360 + 270)
              pointers: <GaugePointer>[
                // RangePointer for the start handle
                RangePointer(
                  value: _startValue,
                  width: 10,
                  color: Colors.orange,
                  enableDragging: true, // Enables dragging of the pointer
                  onValueChanged: (double value) {
                    setState(() {
                      _startValue = value; // Update the start value
                    });
                  },
                ),
                // RangePointer for the end handle
                RangePointer(
                  value: _endValue,
                  width: 10,
                  color: Color(0xFFE5E3E5),
                  enableDragging: true, // Enables dragging of the pointer
                  onValueChanged: (double value) {
                    setState(() {
                      _endValue = value; // Update the end value
                    });
                  },
                ),
              ],
              ranges: <GaugeRange>[
                // Range between two pointers (sliders)
                GaugeRange(
                  startValue: _startValue, // Start of the range
                  endValue: _endValue,     // End of the range
                  color: Colors.orangeAccent.withOpacity(0.3),
                  startWidth: 10,
                  endWidth: 10,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



