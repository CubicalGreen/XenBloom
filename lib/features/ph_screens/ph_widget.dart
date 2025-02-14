import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xen_bloom/features/apis/get_settings.dart';
import '../apis/change_device_range.dart';
import 'dart:ui';
import '../authentication_screens/globalVariable.dart';
import '../Elements/customContainer.dart';

class pHWidget extends StatefulWidget {
  const pHWidget({super.key});

  @override
  State<pHWidget> createState() => _pHWidgetState();
}

class _pHWidgetState extends State<pHWidget> {
  double minPH = (ph_min ?? 5.5);
  double maxPH = (ph_max ?? 6.5);
  final TextEditingController _minController = TextEditingController();
  final TextEditingController _maxController = TextEditingController();

  final deviceService = DeviceService();
  final settings = GetSettings();

  @override
  void initState() {
    super.initState();
    _minController.text = minPH.toString();
    _maxController.text = maxPH.toString();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   fetchAndStorePHSettings();
    // });
  }

  @override
  void dispose() {
    _minController.dispose();
    _maxController.dispose();
    super.dispose();
  }

  Future<void> fetchAndStorePHSettings() async {
    try {
      var data = await settings.getDeviceSettings();
      if (data != null) {
        dynamic phValues = data['pH'];

        setState(() {
          minPH = phValues['min']?.toDouble() ?? minPH;
          maxPH = phValues['max']?.toDouble() ?? maxPH;
        });

        print(" PH Min: $minPH, PH Max: $maxPH");
      }
    } catch (e) {
      print('Error fetching settings: $e');
    }
  }

  void _showInputDialog(String label) {
    TextEditingController controller = TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Enter $label value'),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Enter value'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    double value = double.tryParse(controller.text) ?? 0.0;
                    if (label == "Min.") {
                      minPH = value;
                    } else if (label == "Max.") {
                      maxPH = value;
                    }
                  });
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.poppins(),
                ),
              )
            ],
          );
        });
  }

  void _handleSave() {
    ph_min = minPH;
    ph_max = maxPH;
    deviceService.changeDeviceRange();

    Navigator.of(context).pop();
  }

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
                filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
                // Apply blur effect
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
                    0.42, // Reduced height of the bottom sheet
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            // Align the text to the left
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              // Add padding to keep it away from the edge
                              child: Text(
                                'pH Balance',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.18,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF9cfca6),
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Text(
                                          'Recommended',
                                          style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.0075),
                                  PHScaleWidget(),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 6),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 14.0, right: 14),
                            child: Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _showInputDialog("Min.");
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.13,
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.03),
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
                                                'Min.',
                                                style: GoogleFonts.poppins(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Image.asset(
                                                  'assets/images/refresh_icon.png',
                                                  // Replace with your image path
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
                                          Text(
                                            '$minPH',
                                            style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.02),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      _showInputDialog("Max.");
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.13,
                                      padding: EdgeInsets.all(
                                          MediaQuery.of(context).size.width *
                                              0.03),
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
                                                'Max.',
                                                style: TextStyle(
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Image.asset(
                                                  'assets/images/refresh_icon.png',
                                                  // Replace with your image path
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
                                          Text(
                                            '$maxPH',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 6),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 16.0, left: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle Cancel button press
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    // Button color
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width *
                                            0.44,
                                        50),
                                    // Increase size
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
                                  onPressed: () {
                                    _handleSave();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    // Button color
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.width *
                                            0.44,
                                        50),
                                    // Increase size
                                    textStyle: TextStyle(
                                      fontSize: 18, // Increase text size
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          8), // Reduced border radius
                                    ),
                                  ),
                                  child: Text(
                                    'Save',
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
    // input box will appear with this func() :D
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return CustomContainer(
      onTap: () {
        fetchAndStorePHSettings();
        _showBottomSheet();
      },
      height: h * 0.2,
      width: w * 0.445,
      imagePath: 'assets/images/pH.png',
      title: 'pH',
      value: '5.7',
    );
  }
}

class PHScaleWidget extends StatefulWidget {
  @override
  _PHScaleWidgetState createState() => _PHScaleWidgetState();
}

class _PHScaleWidgetState extends State<PHScaleWidget> {
  double _currentPHValue = 6.3;

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            _currentPHValue.toStringAsFixed(1),
            style: TextStyle(color: Colors.black),
          ),
        ),
        SizedBox(height: 4),
        Stack(
          // alignment: Alignment.center,
          children: [
            // Colorful pH Scale Container
            Container(
              height: h * 0.07,
              width: w * 0.9,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red,
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                    Colors.cyan,
                    Colors.blue,
                    Colors.purple,
                  ],
                  stops: [0.0, 0.16, 0.33, 0.5, 0.66, 0.83, 1.0],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            // Indicator Line
            Positioned(
              left: (_currentPHValue / 14) * (w * 0.9) + 2,
              // Adjust for line width
              top: 0,
              child: Container(
                width: 2,
                height: h * 0.07,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
