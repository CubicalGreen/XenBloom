import 'dart:convert';
import 'package:http/http.dart' as http;
import '../authentication_screens/globalVariable.dart';


class AddSensorData {
  Future<void> addSensorData(double tds, double ph, double waterLevel) async{
    final url = Uri.parse('https://addsensordata-ta72nhrlya-uc.a.run.app');
    String? deviceID = globalDeviceId;
    final payload = {
      "deviceId" : deviceID,
      "sensorData" : {
        "TDS": tds,
        "pH": ph,
        "waterLevel": waterLevel,
      },
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type' : 'application/json'},
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        print('New data added successfully');
      }
      else if (response.statusCode == 400) {
        print('Invalid request');
      }
      else if (response.statusCode == 500) {
        print('Internal server error');
      }
    } catch(error) {
      print(error);
    }
  }
}