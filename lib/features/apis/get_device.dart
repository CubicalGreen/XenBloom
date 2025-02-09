import 'dart:convert';
import 'package:http/http.dart' as http;
import '../authentication_screens/globalVariable.dart';

class GetDeviceData {
  Future<void> getDeviceData() async{
    final url = Uri.parse('https://getdevicedata-ta72nhrlya-uc.a.run.app');
    String? deviceId = globalDeviceId;

    final payload = {
      "deviceId": deviceId,
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print('Device data returned successfully');
        print(response.body);
      }
      else if (response.statusCode == 400) {
        print('Invalid request or device not found: ${response.statusCode}');
      }
      else if (response.statusCode == 500) {
        print('Internal server error: ${response.statusCode}');
      }
    } catch(error) {
      print('Error getting device data: ${error}');
    }
  }
}