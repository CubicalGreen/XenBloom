import 'dart:convert';
import '../apis/get_settings.dart';
import 'package:flutter/material.dart';

final settings = GetSettings();

String? globalUid;
String? globalDeviceId;
String? globalDocumentId;

// Default values
int? tds_min;
int? tds_max;

double? ph_min;
double? ph_max;

int water_level_min = 2;
int water_level_max = 3;

String? totalWaterCycles;

int cycleTimeHour = 1;
int cycleTimeMinute = 0;
int sprinkleDurationSeconds = 0;
int sprinkleDurationMinute = 2;

int globalStartHour = 6;
int globalEndHour = 18;
int globalStartMinute = 0;
int globalEndMinute = 0;

/// Fetch default settings from Firestore and update global variables
Future<void> fetchAndStoreSettings() async {
  try {
    var data = await settings.getDeviceSettings();
    print(data);
    if (data != null) {
      // Extracting values from the response
      dynamic TDS = data['TDS'];
      dynamic phValues = data['pH'];
      print(TDS);

      tds_min = TDS['min'] ?? tds_min;
      tds_max = TDS['max'] ?? tds_max;
      ph_min = phValues['min'].toDouble() ?? ph_min;
      ph_max = phValues['max']?.toDouble() ?? ph_max;
      globalStartHour = data['start_hour'] ?? globalStartHour;
      globalEndHour = data['end_hour'] ?? globalEndHour;
      globalStartMinute = data['start_minute'] ?? globalStartMinute;
      globalEndMinute = data['end_minute'] ?? globalEndMinute;

      print(
          "Settings updated: TDS Min: $tds_min, TDS Max: $tds_max, PH Min: $ph_min, PH Max: $ph_max");
    } else {
      print("No settings retrieved. Using default values.");
    }
  } catch (e) {
    print('Error fetching settings: $e');
  }
}
