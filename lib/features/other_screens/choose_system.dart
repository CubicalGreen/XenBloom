import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xen_bloom/features/home_screen/home_page.dart';

class ChooseSystem extends StatefulWidget {
  @override
  _ChooseSystemState createState() => _ChooseSystemState();
}

class _ChooseSystemState extends State<ChooseSystem> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _firstName;
  // List<String> _systems = []; // Commented out for now

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    // _fetchSystems(); // Commented out for now
  }

  void _fetchUserData() async {
    try {
      _user = _auth.currentUser;
      if (_user != null) {
        setState(() {
          _firstName = _user!.displayName?.split(' ')[0];
        });
      }
    } catch (e) {
      // Handle error (e.g., show a SnackBar or log the error)
      print("Error fetching user data: $e");
    }
  }

  Widget _buildSystemCard(String systemName) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFFF9FBFA),
      elevation: 0, // Remove elevation
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {},
                child: Image.asset(
                  'assets/images/dot_icon.png', // Replace with your image path
                  width: MediaQuery.of(context).size.width * 0.07,
                  color: Colors.grey[500], // Apply the same color as the icon
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.0075),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              systemName,
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.07,
                color: Colors.grey[500],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, top: 60, right: 16, left: 16), // Reduced top padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hiii,',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _firstName ?? '', // Handle null value for _firstName
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(), // Navigate to HomePage widget
                        ),
                      );
                    },
                    child: _buildSystemCard('Gardenia'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(), // Navigate to HomePage widget
                        ),
                      );
                    },
                    child: _buildSystemCard('Green Oasis'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}