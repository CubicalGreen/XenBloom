import 'dart:async'; // Import for Timer
import 'package:flutter/material.dart';
import 'package:xen_bloom/authentication_screens/google_auth.dart';
import '../home_screen/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        SizedBox(height: h * 0.05),
        _buildDots(w, h),
        SizedBox(height: h * 0.03),
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
      MaterialPageRoute(builder: (context) => HomePage()),
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
                  'assets/images/onboarding3.png',
                  'Arrange your documents',
                  'Go paper free and create longitudinal health history and share it with anyone with your consent.',
                  w,
                  h,
                ),
                _buildPage(
                  'assets/images/onboarding1.png',
                  'Track Vitals',
                  'Establish unique identity across different healthcare providers in the country.',
                  w,
                  h,
                ),
                _buildPage(
                  'assets/images/onboarding2.png',
                  'Enter healthcare ecosystem',
                  'Access Various UHI services to ease your medical journey and secure your data.',
                  w,
                  h,
                ),
                _buildPage(
                  'assets/images/onboarding3.png',
                  'Arrange your documents',
                  'Go paper free and create longitudinal health history and share it with anyone with your consent.',
                  w,
                  h,
                ),
                _buildPage(
                  'assets/images/onboarding1.png',
                  'Track Vitals',
                  'Establish unique identity across different healthcare providers in the country.',
                  w,
                  h,
                ),
              ],
            ),
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
