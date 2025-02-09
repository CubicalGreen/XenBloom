import 'dart:convert';

import 'package:http/http.dart' as http;
import '../authentication_screens/globalVariable.dart';

class ChangeDefault {
  Future<void> changeDefault(double tds_min, double tds_max, double ph_min, double ph_max, double water_min, double water_max) async {
    final url = Uri.parse('https://addsensordata-ta72nhrlya-uc.a.run.app');
    String? deviceId = globalDeviceId;

    final payload = {
      "TDS" : {
        "min": tds_min,
        "max": tds_max,
      },
      "pH": {
        "min":ph_min,
        "max":ph_max,
      },
      "waterLevel": {
        "min":water_min,
        "max":water_max,
      },
    };
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload)
      );
    }catch (error) {
      print(error);
    }
  }
}