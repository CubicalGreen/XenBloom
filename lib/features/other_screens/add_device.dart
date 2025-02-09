import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import '../authentication_screens/globalVariable.dart';
class AddDevice{

  Future<void> addDeviceInBackend(String deviceName, String deviceSettings) async {
    String? uid = globalUid;
    String? deviceId = Uuid().v4();
    globalDeviceId = deviceId;
    if (uid == null) {
      print('Error: UId is null');
      return ;
    }
    print('User Id: $uid');
    print('Device Id: $deviceId');

    await addDevice(deviceId, deviceName, deviceSettings, uid);
  }


  Future<void> addDevice(String? deviceId, String device_name, String device_settings, String uid) async{
    final url = Uri.parse("https://adddevice-ta72nhrlya-uc.a.run.app");

    final payload = {
      "deviceId": deviceId,
      "device": {
        "name": device_name,
        "settings": device_settings
      },
      "uid": uid
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        print('Device added successfully');
      }
      else if (response.statusCode == 400) {
        print('Invalid request: ${response.statusCode}');
      }
      else if (response.statusCode == 500) {
        print('Internal server error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

}