import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xen_bloom/authentication_screens/google_auth.dart';
import 'package:xen_bloom/authentication_screens/login_page.dart';
import 'package:xen_bloom/connect_screen.dart';
import 'package:xen_bloom/other_screens/name_screen.dart'; // Ensure this import for FirebaseServices

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width; // Define width here

    void _logout() async {
      // Implement your logout logic here
      await FirebaseServices().googleSignOut(); // Ensure this method exists in your FirebaseServices
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()), // Replace with your login screen or initial route
      );
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue, // Set your preferred color
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: w * 0.06, // Adjust font size
              ),
            ),
          ),
          ListTile(
            // leading: Icon(Icons.logout),
            title: Text('Logout'),
            onTap: () {
              _logout(); // Call logout function
            },
          ),
          ListTile(
            // leading: Icon(Icons.logout),
            title: Text('Connect'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ConnectScreen()), // Navigate to the ConnectScreen
              );
            },
          ),
          ListTile(
            // leading: Icon(Icons.logout),
            title: Text('Name'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NameScreen()), // Navigate to the ConnectScreen
              );
            },
          ),
        ],
      ),
    );
  }
}
