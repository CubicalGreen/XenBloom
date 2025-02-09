import 'package:flutter/material.dart';

class ProfileMenu extends StatelessWidget {
  final VoidCallback onChangeSettings;
  final VoidCallback onTest;

  const ProfileMenu({
    Key? key,
    required this.onChangeSettings,
    required this.onTest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          top: 50, // Adjust distance from the top
          right: 10, // Prevents overflow on the right side
          child: Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            child: Container(
              width: screenWidth * 0.4, // Adjusted width (40% of screen)
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildMenuItem(
                      "Change Settings", Icons.settings, onChangeSettings),
                  Divider(),
                  _buildMenuItem("Test", Icons.play_arrow, onTest),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem(String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: [
            Icon(icon, color: Colors.black54),
            SizedBox(width: 10),
            Expanded(
              // ✅ Prevents overflow
              child: Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.black87),
                overflow: TextOverflow.ellipsis, // ✅ Avoids text overflow
              ),
            ),
          ],
        ),
      ),
    );
  }
}
