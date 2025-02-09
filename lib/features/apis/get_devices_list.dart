import 'package:cloud_firestore/cloud_firestore.dart';

Future<String?> getDocumentNameByUserId(String? userId) async {
  try {
    // Reference the 'users' collection
    CollectionReference usersCollection =
        FirebaseFirestore.instance.collection('users');

    // Query documents where 'userId' matches the provided value
    QuerySnapshot querySnapshot =
        await usersCollection.where('uid', isEqualTo: userId).get();

    // Check if any documents matched
    if (querySnapshot.docs.isNotEmpty) {
      // Return the ID of the first matching document
      return querySnapshot.docs.first.id;
    } else {
      // No matching document found
      print("No document found with userId: $userId");
      return null;
    }
  } catch (e) {
    print("Error retrieving document name by userId: $e");
    return null;
  }
}

Future<List<String>> getDevicesField(String? documentId) async {
  try {
    // Reference the document by its ID in the 'users' collection
    DocumentReference document =
        FirebaseFirestore.instance.collection('users').doc(documentId);

    // Get the document snapshot
    DocumentSnapshot snapshot = await document.get();

    // Check if the document exists
    if (snapshot.exists) {
      // Retrieve the 'devices' field and ensure it's a List
      var devicesField = snapshot
          .get('devices'); // Replace 'devices' with the exact field name

      if (devicesField is List) {
        // Extract only the 'name' field from each device
        return devicesField.map((device) => device['name'].toString()).toList();
      } else {
        print("'devices' field is not a list.");
        return [];
      }
    } else {
      print("Document with ID $documentId does not exist.");
      return [];
    }
  } catch (e) {
    print("Error retrieving devices field: $e");
    return [];
  }
}

Future<String?> getDeviceIdByName(
    String? documentId, String? deviceName) async {
  try {
    // Reference the document in the 'users' collection
    DocumentReference document =
        FirebaseFirestore.instance.collection('users').doc(documentId);

    // Get the document snapshot
    DocumentSnapshot snapshot = await document.get();

    // Check if the document exists
    if (snapshot.exists) {
      // Retrieve the 'devices' field
      var devicesField = snapshot.get('devices');

      // Ensure the 'devices' field is a list
      if (devicesField is List) {
        // Iterate over the devices and find the one with the matching name
        for (var device in devicesField) {
          if (device is Map<String, dynamic> && device['name'] == deviceName) {
            return device['id'].toString(); // Return the device ID
          }
        }

        print("Device with name '$deviceName' not found.");
        return null; // Return null if the device is not found
      } else {
        print("'devices' field is not a list.");
        return null;
      }
    } else {
      print("Document with ID '$documentId' does not exist.");
      return null;
    }
  } catch (e) {
    print("Error occurred: $e");
    return null;
  }
}
