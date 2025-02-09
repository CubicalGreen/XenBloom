import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future<Map<String, dynamic>?> fetchMessage(String? globalDeviceId) async {
  try {
    CollectionReference updateLog =
        FirebaseFirestore.instance.collection('update_log');

    QuerySnapshot querySnapshot = await updateLog
        .where('deviceId', isEqualTo: globalDeviceId)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;

      String message = doc['message'];
      String formattedTime = DateFormat.Hm().format(DateTime.now());

      return {
        'message': message,
        'retrievalTime': formattedTime,
      };
    } else {
      return null;
    }
  } catch (e) {
    print('Error retrieving message: $e');
    return null;
  }
}
