import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:xen_bloom/Elements/bottomNavBar.dart';
import 'package:xen_bloom/Elements/customContainer.dart';
import 'package:xen_bloom/Elements/customDrawer.dart';
import 'package:xen_bloom/Elements/customSlider.dart';
import 'package:xen_bloom/Elements/waterContainer.dart';
import 'package:xen_bloom/authentication_screens/google_auth.dart';
import 'package:xen_bloom/authentication_screens/login_page.dart'; // Ensure you have this import

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _sliderValue = 0.7; // Initial value
  int _selectedIndex = 0; // Index for bottom navigation bar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // void _logout() async {
  //   // Implement your logout logic here
  //   await FirebaseServices().googleSignOut(); // Ensure this method exists in your FirebaseServices
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your login screen or initial route
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Next Cycle Countdown
            Container(
              height: h * 0.17,
              padding: EdgeInsets.only(
                  top: h * 0.068, left: w * 0.04, right: w * 0.04),
              decoration: BoxDecoration(
                color: Colors.grey[100],
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
            SizedBox(height: h * 0.007),
            // Main Content
            Row(
              children: [
                // Left Container
                Container(
                  height: h * 0.41,
                  width: w * 0.445,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey.shade300,
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
                    CustomContainer(
                      height: h * 0.2,
                      width: w * 0.445,
                      imagePath: 'assets/images/pH.png',
                      title: 'pH',
                      value: '5.7',
                    ),
                  ],
                ),
              ],
            ),
            // Water Level Screen
            SizedBox(height: h * 0.01),
            WaterContainer(),
            SizedBox(height: h * 0.02),
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
                    color: Colors.grey.shade400,
                    strokeWidth: 1,
                    child: Center(
                      child: Text(
                        'Add a device',
                        style: TextStyle(
                          color: Colors.grey.shade400,
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
