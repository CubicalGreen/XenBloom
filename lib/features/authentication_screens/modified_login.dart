import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import '../../connect_screen.dart';
import '../home_screen/home_page.dart';
import 'google_auth.dart';

class mLoginScreen extends StatefulWidget {
  const mLoginScreen({super.key});

  @override
  State<mLoginScreen> createState() => _mLoginScreenState();
}

class _mLoginScreenState extends State<mLoginScreen> {
  final PageController _pageController = PageController(initialPage: 1);
  int _currentPage = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer to automatically change pages
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 3) {
        _currentPage++;
      } else {
        _currentPage = 1; // Loop back to the first actual page
        _pageController.jumpToPage(1);
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    _pageController.dispose();
    super.dispose();
  }

  Widget _buildPage(String imagePath, String title, String description, double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath, height: h * 0.5, width: w * 0.95),
        SizedBox(height: h * 0.1),

        Text(
          title,
          style: TextStyle(fontSize: w * 0.065, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: h * 0.01),
        Text(
          description,
          style: TextStyle(fontSize: w * 0.05, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildDots(double w, double h) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        bool isCurrentPage = _currentPage == index + 1;
        bool isBeforeCurrentPage = _currentPage > index + 1;
        bool isAfterCurrentPage = _currentPage < index + 1;

        double dotSize = isCurrentPage ? w * 0.1 : w * 0.075;
        Color dotColor = isCurrentPage
            ? Colors.black
            : isBeforeCurrentPage
            ? Colors.grey.shade500
            : Colors.grey.shade300;

        return AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: w * 0.02),
          width: dotSize,
          height: h * 0.005,
          decoration: BoxDecoration(
            color: dotColor,
            borderRadius: BorderRadius.circular(h * 0.005),
          ),
        );
      }),
    );
  }

  void _authenticate() async {
    await FirebaseServices().signinWithGoogle();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ConnectScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                if (index == 0) {
                  _currentPage = 3;
                  _pageController.jumpToPage(3);
                } else if (index == 4) {
                  _currentPage = 1;
                  _pageController.jumpToPage(1);
                } else {
                  setState(() {
                    _currentPage = index;
                  });
                }
              },
              physics: NeverScrollableScrollPhysics(), // Disable manual swiping
              children: [
                _buildPage(
                  'assets/images/orboardingImage3.png',
                  'Experience Hassle-Free Farming',
                  'Say goodbye to the stress of traditional gardening with our fully automated, easy-to-use system.',
                  w,
                  h,
                ),
                _buildPage(
                  'assets/images/onbordingImage1.png',
                  'Fresh, Nutrient-Rich Produce',
                  'Harvest your own fresh, nutrient-rich fruits and vegetables right at home.',
                  w,
                  h,
                ),
                _buildPage(
                  'assets/images/orboardingImage2.png',
                  'Maximize Your Space',
                  'Grow up to 30 plants in a sleek, compact design that fits effortlessly into any indoor space.',
                  w,
                  h,
                ),
                _buildPage(
                  'assets/images/orboardingImage3.png',
                  'Experience Hassle-Free Farming',
                  'Say goodbye to the stress of traditional gardening with our fully automated, easy-to-use system.',
                  w,
                  h,
                ),
                _buildPage(
                  'assets/images/onbordingImage1.png',
                  'Fresh, Nutrient-Rich Produce',
                  'Harvest your own fresh, nutrient-rich fruits and vegetables right at home.',
                  w,
                  h,
                ),
              ],
            ),
          ),
          Positioned(
            top: h * 0.7, // Position the dots at a fixed position
            left: 0,
            right: 0,
            child: _buildDots(w, h),
          ),
          Padding(
            padding: EdgeInsets.only(left: w * 0.05, right: w * 0.05, top: h * 0.1, bottom: h * 0.02),
            child: Column(
              children: [
                Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _authenticate,
                    icon: Padding(
                      padding: EdgeInsets.only(left: w * 0.02),
                      child: Text(
                        'Continue with',
                        style: TextStyle(fontSize: w * 0.05),
                      ),
                    ),
                    label: Image.asset(
                      'assets/images/Google.png',
                      height: h * 0.03,
                      width: h * 0.03,
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(horizontal: w * 0.125, vertical: h * 0.02),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: h * 0.03,
            right: w * 0.05,
            child: Image.asset(
              'assets/images/language_option.png',
              height: h * 0.08,
              width: w * 0.12,
            ),
          ),
        ],
      ),
    );
  }
}
