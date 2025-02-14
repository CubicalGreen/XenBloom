import 'dart:math';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:ui';
import '../authentication_screens/globalVariable.dart';
import 'package:xen_bloom/features/time_screens/drag_timer.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class timeUpdateWidget extends StatefulWidget {
  const timeUpdateWidget({super.key});

  @override
  State<timeUpdateWidget> createState() => _timeUpdateWidgetState();
}

class _timeUpdateWidgetState extends State<timeUpdateWidget> {
  int startHour = globalStartHour;
  int endHour = globalEndHour;
  int startMinute = globalStartMinute;
  int endMinute = globalEndMinute;

  int countdown = 0;
  Timer? timer;

  final TextEditingController durationController =
      TextEditingController(text: '2:00');

  final TextEditingController cycleHandleController =
      TextEditingController(text: '1:00');

  void newNotif() {
    AwesomeNotifications().initialize(
        null,
        [
          NotificationChannel(
              channelKey: 'channelKey',
              channelName: 'channelName',
              channelDescription: 'channelDescription'),
        ],
        debug: true);
  }

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    durationController.text =
        "${sprinkleDurationMinute.toString().padLeft(2, '0')}:${sprinkleDurationSeconds.toString().padLeft(2, '0')}";
    cycleHandleController.text =
        "${cycleTimeHour.toString().padLeft(2, '0')}:${cycleTimeMinute.toString().padLeft(2, '0')}";
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
    newNotif();
  }

  void triggerNotification() {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'channelKey',
          title: 'System Refill',
          body: 'System is being Refilled'),
    );
  }

  void _updateCountdown() {
    setState(() {
      countdown = (endHour - startHour) * 60;
    });
    int hours = countdown ~/ 60;
    int minutes = countdown % 60;
    timer?.cancel();
    timer = Timer.periodic(Duration(minutes: 1), (timer) {
      print("Current Minute: $countdown");
      if (countdown > 0) {
        setState(() {
          countdown--;
        });
      } else {
        timer.cancel();

        triggerNotification();
      }
    });
  }

  void _onTimeChanged(double newStartHour, double newEndHour) {
    setState(() {
      startHour = newStartHour.toInt();
      endHour = newEndHour.toInt();
    });
    _updateCountdown();
  }

  void _showBottomSheet() {
    print("Start hour: ${startHour} , End Hour: ${endHour}");
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
                filter: ImageFilter.blur(
                    sigmaX: 2.0, sigmaY: 2.0), // Apply blur effect
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
                    0.63, // Reduced height of the bottom sheet
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Align(
                          alignment: Alignment
                              .centerLeft, // Align the text to the left
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            // Add padding to keep it away from the edge
                            child: Text(
                              'Water Regulation Cycle',
                              style: GoogleFonts.poppins(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 16.0, right: 16.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 1.0,
                            height: MediaQuery.of(context).size.height * 0.4,
                            padding: EdgeInsets.all(
                                MediaQuery.of(context).size.width * 0.03),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.of(context).size.width * 0.03),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircularDragTimerWidget(
                                  onTimeChanged: _onTimeChanged,
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(left: 14.0, right: 14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.03),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                  ),
                                  child: ListView(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '',
                                            style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Image.asset(
                                              'assets/images/water_drops_bold.png',
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
                                      Row(
                                        children: [
                                          Text(
                                            '02:00',
                                            style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Transform.translate(
                                                    offset: Offset(
                                                        0,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                    // Adjust the offset for subscript effect
                                                    child: Text(
                                                      ' Secs', // Subscript text
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        color: Colors.grey[800],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.02),
                              Expanded(
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.03),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        MediaQuery.of(context).size.width *
                                            0.03),
                                  ),
                                  child: ListView(
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.05,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Image.asset(
                                              'assets/images/time_clock.png',
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
                                      Row(
                                        children: [
                                          Text(
                                            '01:00',
                                            style: GoogleFonts.poppins(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                          Text.rich(
                                            TextSpan(
                                              children: [
                                                WidgetSpan(
                                                  child: Transform.translate(
                                                    offset: Offset(
                                                        0,
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.01),
                                                    // Adjust the offset for subscript effect
                                                    child: Text(
                                                      ' Hrs', // Subscript text
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.04,
                                                        color: Colors.grey[800],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0, left: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Handle Cancel button press
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white, // Button color
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.44,
                                      50), // Increase size
                                  textStyle: GoogleFonts.poppins(
                                    fontSize: 18, // Increase text size
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Reduced border radius
                                  ),
                                ),
                                child: Text(
                                  'Cancel',
                                  style:
                                      GoogleFonts.poppins(color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black, // Button color
                                  minimumSize: Size(
                                      MediaQuery.of(context).size.width * 0.44,
                                      50), // Increase size
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
                                  style:
                                      GoogleFonts.poppins(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () => _showBottomSheet(),
      child: Container(
        height: h * 0.17,
        padding:
            EdgeInsets.only(top: h * 0.068, left: w * 0.04, right: w * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Next Cycle in',
                style: GoogleFonts.poppins(fontSize: 20),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '$countdown',
                    style: GoogleFonts.poppins(fontSize: 35),
                  ),
                  SizedBox(width: 4),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      'mins',
                      style: GoogleFonts.poppins(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
