import 'dart:convert';
import 'package:http/http.dart' as http;
import '../authentication_screens/globalVariable.dart';

class DeviceService {
  Future<void> changeDeviceRange() async {
    print('function is running');
    final url = Uri.parse('https://changedevicerange-ta72nhrlya-uc.a.run.app/');
    String? deviceId = globalDeviceId;

    final payload = {
      "newRange": {
        "TDS": {
          "min": tds_min,
          "max": tds_max,
        },
        "pH": {
          "min": ph_min,
          "max": ph_max,
        },
        "waterLevel": {"min": water_level_min, "max": water_level_max},
      },
      "deviceId": deviceId,
    };

    print(payload);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        // Successfully updated device range

        print("Device range updated successfully: ${response.body}");
      } else if (response.statusCode == 500) {
        print("some error occurred: ${response.body}");
      } else if (response.statusCode == 400) {
        print("400 status code occurred: ${response}");
      }
    } catch (error) {
      // Handle network or other errors
      print("An error occurred: $error");
    }
  }
}
