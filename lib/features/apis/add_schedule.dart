import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../authentication_screens/globalVariable.dart';

class AddSchedule {
  //
  // {
  // "taskName": "lights",
  // "scheduledTime": "15:30",
  // "action": true,
  // "deviceId": "device12345"
  // }
  Future<void> add_schedule(String? taskName, String? scheduledTime,
      bool action, String? deviceId) async {
    final url = Uri.parse('https://addschedule-ta72nhrlya-uc.a.run.app/');

    final payload = {
      "taskName": taskName,
      "scheduledTime": scheduledTime,
      "action": action,
      "deviceId": deviceId,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        print('Scheduled added successfully!');
      } else {
        print('Couldnt add the schedule');
      }
    } catch (error) {
      print('Error ${error}');
    }
  }
}
