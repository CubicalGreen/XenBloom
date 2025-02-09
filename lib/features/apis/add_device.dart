import 'dart:convert';
import 'package:http/http.dart' as http;
import '../authentication_screens/globalVariable.dart';

class AddDevice {
  Future<void> add_device(String? DeviceName, String? DeviceSettings) async {
    String? uid = globalUid;
    String? deviceId = globalDeviceId;

    final url = Uri.parse("https://adddevice-ta72nhrlya-uc.a.run.app/");

    final payload = {
      "deviceId": deviceId,
      "device": {
        "name": DeviceName,
        "settings": DeviceSettings,
      },
      "uid": uid,
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        print("New Device Added Successfully!!!");
      } else {
        print("An error occurred while adding a device: ");
      }
    } catch (error) {
      print('Error: ${error}');
    }
  }
}
