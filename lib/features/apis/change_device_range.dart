import 'dart:convert';
import 'package:http/http.dart' as http;

class DeviceService {
  Future<void> changeDeviceRange(String deviceId, Map<String, dynamic> newRange) async {
    final url = Uri.parse('https://your-backend-url.com/changeDeviceRange');

    final payload = {
      "newRange": newRange,
      "deviceId": deviceId
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print('Device range updated successfully');
      } else if (response.statusCode == 400) {
        print('Invalid request: ${response.body}');
      } else if (response.statusCode == 500) {
        print('Internal server error: ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
