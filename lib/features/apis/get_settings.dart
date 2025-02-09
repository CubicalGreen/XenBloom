import 'dart:convert';
import 'package:http/http.dart' as http;
import '../authentication_screens/globalVariable.dart';

class GetSettings {
  Future<Map<String, dynamic>?> getDeviceSettings() async {
    String? deviceId = globalDeviceId;

    final url = Uri.parse("https://getsettings-ta72nhrlya-uc.a.run.app");
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
        print("Settings retrieved successfully");
        // Parse the response body as a Map
        final decodedResponse =
            jsonDecode(response.body) as Map<String, dynamic>;
        return decodedResponse["data"] as Map<String, dynamic>;
      } else {
        print(
            "Failed to retrieve settings. Status code: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("An error occurred: $e");
      return null;
    }
  }
}
