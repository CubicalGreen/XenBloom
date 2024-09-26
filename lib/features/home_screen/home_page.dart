import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:xen_bloom/features/time_screens/time_update.dart';
import '../Elements/bottomNavBar.dart';
import '../Elements/customContainer.dart';
import '../Elements/customDrawer.dart';
import '../Elements/myWidget.dart';
import '../Elements/waterContainer.dart';
import '../ph_screens/ph_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _sliderValue = 0.7; // Initial value
  int _selectedIndex = 0; // Index for bottom navigation bar
  bool _isChecked = false; // Initial checkbox value

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Builder(
          builder: (BuildContext context) => IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.black,
            onPressed: () {
              // Handle notifications action
            },
          ),
          IconButton(
            icon: ImageIcon(
              AssetImage('assets/images/profile.png'), // Path to your home image asset
              color: Colors.black,
              size: 28,
            ),
            color: Colors.black,
            onPressed: () {
              // Handle settings action
            },
          ),
        ],
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.only(top: 5.0, right: 16, left: 16, bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 8,bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "To Do",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            'assets/images/dot_icon.png', // Add the path to your dot image here
                            width: 25, // Adjust the size as needed
                            height: 35,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey.shade200, // Adjust the color as needed
                      width: double.infinity, // Ensures the line takes up the full width
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: Colors.red, // Change the color of the checkbox
                        ),
                        Text(
                          "Refill the reservoir",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: h * 0.01),
              // Header: Next Cycle Countdown
              // Container(
              //   height: h * 0.17,
              //   padding: EdgeInsets.only(
              //       top: h * 0.068, left: w * 0.04, right: w * 0.04),
              //   decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              //   child: Align(
              //     alignment: Alignment.bottomLeft,
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text(
              //           'Next Cycle in',
              //           style: TextStyle(fontSize: 20),
              //         ),
              //         Row(
              //           crossAxisAlignment: CrossAxisAlignment.baseline,
              //           textBaseline: TextBaseline.alphabetic,
              //           children: [
              //             Text(
              //               '28:42',
              //               style: TextStyle(fontSize: 35),
              //             ),
              //             SizedBox(width: 4),
              //             Align(
              //               alignment: Alignment.bottomCenter,
              //               child: Text(
              //                 'mins',
              //                 style: TextStyle(fontSize: 20),
              //               ),
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
                
              // ),
              timeUpdateWidget(),
              SizedBox(height: h * 0.007),
              // Main Content
              Row(
                children: [
                  containerWidget(),
                  SizedBox(width: w * 0.02),
                  Column(
                    children: [
                      CustomContainer(
                        height: h * 0.2,
                        width: w * 0.445,
                        imagePath: 'assets/images/concerntration.png',
                        title: 'Concentration',
                        value: '805',
                        unit: 'ppm',
                      ),
                      SizedBox(height: h * 0.01),
                      pHWidget(),
                    ],
                  ),
                ],
              ),
              // Water Level Screen
              SizedBox(height: h * 0.01),
              WaterContainer(),
              SizedBox(height: h * 0.02),
              // Updates Section
              Container(
                padding: EdgeInsets.only(top: 12,bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Updates",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            'assets/images/dot_icon.png', // Add the path to your dot image here
                            width: 25, // Adjust the size as needed
                            height: 35,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey.shade200, // Adjust the color as needed
                      width: double.infinity, // Ensures the line takes up the full width
                    ),
                    SizedBox(height: 8),
                    _buildUpdateRow('08:00', 'ph was recorded 6.8'),
                    _buildUpdateRow('08:06', 'ph was balanced to 5.6'),
                    _buildUpdateRow('08:06', 'Nutrients Concentration was recorded 600 ppm'),
                    _buildUpdateRow('08:06', 'Nutrients Concentration was balanced to 950 ppm'),
                  ],
                ),
              ),


              SizedBox(height: h * 0.02),
              // Add Device Button
              GestureDetector(
                onTap: () {},
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: w * 0.9,
                    height: h * 0.07,
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      dashPattern: [3, 4],
                      color: Colors.grey.shade800,
                      strokeWidth: 1,
                      child: Center(
                        child: Text(
                          'Add a device',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          CustomBottomNavigationBarItem(
            imagePath: 'assets/images/bottomnavbar_home.png',
          ),
          CustomBottomNavigationBarItem(
            imagePath: 'assets/images/bottomnavbar_2.png',
          ),
          CustomBottomNavigationBarItem(
            imagePath: 'assets/images/bottomnavbar_3.png',
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateRow(String time, String update) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,left: 12,right: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Text(
              update,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}


class CustomSlider extends StatefulWidget {
  final double value; // Current value of the slider
  final ValueChanged<double> onChanged; // Callback when value changes

  CustomSlider({
    required this.value,
    required this.onChanged,
  });

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value;
  }

  @override
  void didUpdateWidget(CustomSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      setState(() {
        _currentValue = widget.value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: Color.fromARGB(255, 28, 215, 144),
      value: _currentValue,
      min: 0,
      max: 1, // Adjust the max value as needed
      onChanged: (newValue) {
        setState(() {
          _currentValue = newValue;
        });
        widget.onChanged(newValue); // Notify parent about the change
      },
    );
  }
}

