import 'package:flutter/material.dart';
import '../Elements/bottomNavBar.dart';
import '../Elements/last_updated_card.dart';

class pHScreen extends StatefulWidget {
  @override
  State<pHScreen> createState() => _pHScreenState();
}

class _pHScreenState extends State<pHScreen> {
  int _selectedIndex = 0; // Index for bottom navigation bar
  double currentPH = 6.3; // Manually set pH value

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _updatePH(double newPH) {
    setState(() {
      currentPH = newPH;
      print("Updated pH value: $currentPH"); // Debugging line
    });
  }

  double _calculateTopOffset(double pH, double barHeight) {
    double minPH = 0.0;
    double maxPH = 14.0;
    double offset = barHeight - (pH - minPH) * (barHeight / (maxPH - minPH));
    print("Calculated top offset: $offset"); // Debugging line
    return offset;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    double barHeight = h * 0.4;

    return Scaffold(
      appBar: AppBar(
        title: Text('pH', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(w * 0.03),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.5),
                //     spreadRadius: w * 0.005,
                //     blurRadius: w * 0.02,
                //     offset: Offset(0, w * 0.01),
                //   ),
                // ],
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(top: h * 0.01, bottom: h * 0.01),
                  child: Container(
                    height: barHeight,
                    width: w * 0.2,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Gradient Bar
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Container(
                            height: barHeight,
                            width: w * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(w * 0.03),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.red,
                                  Colors.orange,
                                  Colors.yellow,
                                  Colors.green,
                                  Colors.cyan,
                                  Colors.blue,
                                  Colors.purple,
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Pointing Container with Arrow
                        Positioned(
                          top: h * 0.4 - (h * 0.4 * 6.5 / 14) + (h * 0.4 * 6.5 / (2 * 14)),
                          left: w * 0.3,
                          child: Text(
                            'Too Acidic',
                            style: TextStyle(fontSize: w * 0.035, color: Colors.grey[600]),
                          ),
                        ),
                        Positioned(
                          top: h * 0.4 - (h * 0.4 * 6.5 / 14) - (h * 0.4 * 1 / 14) + (h * 0.4 * 1 / (2 * 14)),
                          left: w * 0.3,
                          child: Text(
                            'Recommended',
                            style: TextStyle(fontSize: w * 0.035, color: Colors.grey[600]),
                          ),
                        ),
                        Positioned(
                          top: h * 0.4 - (h * 0.4 * 6.5 / 14) - (h * 0.4 * 1 / 14) - (h * 0.4 * 6.5 / 14) + (h * 0.4 * 6.5 / (2 * 14)),
                          left: w * 0.3,
                          child: Text(
                            'Too Basic',
                            style: TextStyle(fontSize: w * 0.035, color: Colors.grey[600]),
                          ),
                        ),
                        Positioned(
                          top: _calculateTopOffset(currentPH, barHeight) - (w * 0.05), // Adjust to center the arrow
                          left: -w * 0.1, // Adjust this value to align the arrow
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(vertical: h * 0.01, horizontal: w * 0.02),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(w * 0.05),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.withOpacity(0.5),
                                  //     spreadRadius: w * 0.001,
                                  //     blurRadius: w * 0.01,
                                  //     offset: Offset(0, w * 0.005),
                                  //   ),
                                  // ],
                                ),
                                child: Text(
                                  currentPH.toStringAsFixed(1),
                                  style: TextStyle(
                                    fontSize: w * 0.045,
                                    color: Colors.grey[800],
                                  ),
                                ),
                              ),
                              SizedBox(height: h * 0.01),
                              // Container(
                              //   width: 0,
                              //   height: 0,
                              //   decoration: BoxDecoration(
                              //     border: Border(
                              //       left: BorderSide(width: w * 0.02, color: Colors.transparent),
                              //       right: BorderSide(width: w * 0.02, color: Colors.transparent),
                              //       bottom: BorderSide(width: w * 0.02, color: Colors.white),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Other UI elements...
            SizedBox(height: h * 0.01),
            LastUpdateCard(),
            SizedBox(height: h * 0.01),
            // Other UI elements...
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: h*0.12,
                    padding: EdgeInsets.all(w * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(w * 0.03),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.2),
                      //     spreadRadius: w * 0.005,
                      //     blurRadius: w * 0.02,
                      //     offset: Offset(0, w * 0.01),
                      //   ),
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Min.',
                              style: TextStyle(
                                fontSize: w * 0.05,
                                color: Colors.grey[600],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Image.asset(
                                'assets/images/refresh_icon.png', // Replace with your image path
                                width: w * 0.07,
                                color: Colors.grey[400], // Apply the same color as the icon
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.0075),
                        Text(
                          '5.5',
                          style: TextStyle(
                            fontSize: w * 0.08,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: w * 0.03),
                Expanded(
                  child: Container(
                    height: h*0.12,
                    padding: EdgeInsets.all(w * 0.03),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(w * 0.03),
                      // boxShadow: [
                      //   BoxShadow(
                      //     color: Colors.grey.withOpacity(0.2),
                      //     spreadRadius: w * 0.005,
                      //     blurRadius: w * 0.02,
                      //     offset: Offset(0, w * 0.01),
                      //   ),
                      // ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Max.',
                              style: TextStyle(
                                fontSize: w * 0.05,
                                color: Colors.grey[600],
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: Image.asset(
                                'assets/images/refresh_icon.png', // Replace with your image path
                                width: w * 0.07,
                                color: Colors.grey[400], // Apply the same color as the icon
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: h * 0.0075),
                        Text(
                          '6.5',
                          style: TextStyle(
                            fontSize: w * 0.08,
                            // fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: h * 0.01),
            Center(
              child: SizedBox(
                width: w * 0.9,
                height: h * 0.07,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                  ),
                  child: Text('Save Changes', style: TextStyle(color: Colors.white, fontSize: w * 0.05)),
                ),
              ),
            ),
          ],
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
}
