import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final String imagePath;
  final String title;
  final String value;
  final String? unit;
  final VoidCallback? onTap;

  const CustomContainer({
    required this.height,
    required this.width,
    required this.imagePath,
    required this.title,
    required this.value,
    this.unit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.5, left: width * 0.03),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          value,
                          style: TextStyle(fontSize: 35),
                        ),
                        if (unit != null) ...[
                          SizedBox(width: 4),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              unit!,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 3.0,
            left: 3.0,
            child: Image.asset(
              imagePath,
              height: 40.0,
              width: 40.0,
            ),
          ),
        ],
      ),
    );
  }
}
