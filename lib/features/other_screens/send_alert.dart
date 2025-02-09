import '../authentication_screens/globalVariable.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SendAlert{
  Future<void> sendAlert(String message) async{
    String? deviceId = globalDeviceId;
    await generateAlert(deviceId, message);
  }

  Future<void> generateAlert(String? deviceId, String message) async{
    final url = Uri.parse('https://sendalert-ta72nhrlya-uc.a.run.app');

    final Map<String, String?> queryParams = {
      'deviceId': deviceId,
      'message': message
    };

    final uriWithParams = url.replace(queryParameters: queryParams);

    try {
      final response = await http.post(
        uriWithParams,
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print('Alert sent successfully');
      } else if (response.statusCode == 400) {
        print('Missing required parameters: ${response.statusCode}');
      } else if (response.statusCode == 404) {
        print('User not found: ${response.statusCode}');
      } else if (response.statusCode == 500) {
        print('Internal server error: ${response.statusCode}');
      }
    } catch(error) {
      print('Error generating alert: ${error}');
    }
  }
}