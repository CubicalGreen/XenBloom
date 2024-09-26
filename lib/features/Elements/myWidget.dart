import 'package:flutter/material.dart';
import 'dart:ui';

class containerWidget extends StatefulWidget {
  @override
  _containerWidgetState createState() => _containerWidgetState();
}

class _containerWidgetState extends State<containerWidget> {
  double _sliderValue = 0.0;
  String _selectedStartTime = '10:00';
  String _selectedEndTime = '12:00';

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
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0), // Apply blur effect
                child: Container(
                  color: Color(0xFF494e52).withOpacity(0.5), // Grey color with opacity
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:35.0,right: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.white,size: 30,), // Down arrow icon
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
                height: MediaQuery.of(context).size.height * 0.36, // Reduced height of the bottom sheet
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft, // Align the text to the left
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0), // Add padding to keep it away from the edge
                              child: Text(
                                'Grow Lights',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // Card 1
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.12,
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.sunny, color: Colors.grey,),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.0075),
                                      Text(
                                        '06:00',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.08,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Card 2
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.12,
                                  width: MediaQuery.of(context).size.width * 0.45,
                                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.nights_stay_outlined, color: Colors.grey,),
                                        ],
                                      ),
                                      SizedBox(height: MediaQuery.of(context).size.height * 0.0075),
                                      Text(
                                        '18:00',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.08,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.03),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.05,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF9cfca6),
                                          borderRadius: BorderRadius.circular(20.0),
                                        ),
                                        child: Text(
                                          'Recommended',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context).size.width * 0.05,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.0075),
                                  Row(
                                    children: [
                                      Text(
                                        '14:00',
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context).size.width * 0.08,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          children: [
                                            WidgetSpan(
                                              child: Transform.translate(
                                                offset: Offset(0, MediaQuery.of(context).size.width * 0.01), // Adjust the offset for subscript effect
                                                child: Text(
                                                  ' Hrs', // Subscript text
                                                  style: TextStyle(
                                                    fontSize: MediaQuery.of(context).size.width * 0.04,
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
                          SizedBox(height: 6),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0,left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle Cancel button press
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white, // Button color
                                    minimumSize: Size(MediaQuery.of(context).size.width * 0.44, 50), // Increase size
                                    textStyle: TextStyle(
                                      fontSize: 18, // Increase text size
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // Reduced border radius
                                    ),
                                  ),
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(width: 5,),
                                ElevatedButton(
                                  onPressed: () {
                                    _showSecondBottomSheet(); // Show the second bottom sheet
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black, // Button color
                                    minimumSize: Size(MediaQuery.of(context).size.width * 0.44, 50), // Increase size
                                    textStyle: TextStyle(
                                      fontSize: 18, // Increase text size
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8), // Reduced border radius
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







  Widget _buildTimeSelector(List<String> times, bool isStart) {
    String selectedTime = isStart ? _selectedStartTime : _selectedEndTime;

    return SizedBox(
      height: 250, // Height to show five items at a time
      width: 150,  // Fixed width
      child: ListWheelScrollView(
        itemExtent: 50,
        physics: FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() {
            if (isStart) {
              _selectedStartTime = times[index];
            } else {
              _selectedEndTime = times[index];
            }
          });
        },
        children: times.map((time) {
          return Container(
            alignment: Alignment.center,
            color: Colors.white, // All items have a white background
            child: Text(
              time,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black, // All text is black
                fontWeight: time == selectedTime ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }





  void _showSecondBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            // The grey and blurry background that covers the entire screen
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0), // Apply blur effect
                child: Container(
                  color: Color(0xFF494e52).withOpacity(0.5), // Grey color with opacity
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0, right: 8),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.white, size: 30), // Down arrow icon
                  onPressed: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.52, // Adjusted height
                child: Padding(
                  padding: const EdgeInsets.only(left: 14.0, right: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft, // Align the text to the left
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20.0), // Add padding to keep it away from the edge
                          child: Text(
                            'Grow Lights',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0), // Circular border
                        ),
                        child: Column(
                          children: [
                            Text(
                              '10:00-18:00',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TimeSelector(
                                  times: _getStartTimeList(),
                                  isStart: true,
                                ),
                                TimeSelector(
                                  times: _getEndTimeList(),
                                  isStart: false,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the bottom sheet
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white, // Button color
                              minimumSize: Size(MediaQuery.of(context).size.width * 0.44, 50), // Button size
                              textStyle: TextStyle(
                                fontSize: 18, // Text size
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Border radius
                              ),
                            ),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Handle save action
                              Navigator.of(context).pop(); // Close the bottom sheet
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, // Button color
                              minimumSize: Size(MediaQuery.of(context).size.width * 0.44, 50), // Button size
                              textStyle: TextStyle(
                                fontSize: 18, // Text size
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8), // Border radius
                              ),
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }


  List<String> _getStartTimeList() {
    return List.generate(13, (index) => index.toString().padLeft(2, '0') + ':00');
  }


  List<String> _getEndTimeList() {
    List<String> endTimeList = List.generate(12, (index) => (index + 12).toString().padLeft(2, '0') + ':00');
    endTimeList.add('24:00');
    return endTimeList;
  }


  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () {
        _showBottomSheet();
      },
      child: Container(
        height: h * 0.41,
        width: w * 0.445,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white,
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: h * 0.32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomSlider(
                value: _sliderValue,
                onChanged: (newValue) {
                  setState(() {
                    _sliderValue = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const CustomSlider({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      min: 0.0,
      max: 100.0,
      onChanged: onChanged,
    );
  }
}


class TimeSelector extends StatefulWidget {
  final List<String> times;
  final bool isStart;

  TimeSelector({required this.times, required this.isStart});

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  late String _selectedTime;
  String _selectedStartTime = '10:00';
  String _selectedEndTime = '12:00';

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.isStart ? _selectedStartTime : _selectedEndTime;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250, // Height to show five items at a time
      width: 150,  // Fixed width
      child: ListWheelScrollView(
        itemExtent: 50,
        physics: FixedExtentScrollPhysics(),
        onSelectedItemChanged: (index) {
          setState(() {
            _selectedTime = widget.times[index];
            if (widget.isStart) {
              _selectedStartTime = _selectedTime;
            } else {
              _selectedEndTime = _selectedTime;
            }
          });
        },
        children: widget.times.map((time) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: time == _selectedTime ? Colors.black : Colors.white, // Change background color
              borderRadius: time == _selectedTime ? BorderRadius.circular(25) : BorderRadius.zero, // Apply circular border only to the selected container
              border: time == _selectedTime ? Border.all(
                color: Colors.black, // Border color
                width: 2, // Border width
              ) : null, // No border for non-selected containers
            ),
            child: Text(
              time,
              style: TextStyle(
                fontSize: 18,
                color: time == _selectedTime ? Colors.white : Colors.black, // Change text color
                fontWeight: time == _selectedTime ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );

        }).toList(),
      ),
    );
  }
}

