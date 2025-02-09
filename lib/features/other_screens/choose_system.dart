import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xen_bloom/features/home_screen/home_page.dart';
import '../apis/get_devices_list.dart';
import '../authentication_screens/globalVariable.dart';

class ChooseSystem extends StatefulWidget {
  @override
  _ChooseSystemState createState() => _ChooseSystemState();
}

class _ChooseSystemState extends State<ChooseSystem> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _firstName;
  List<String> devices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
    fetchDevices();
  }

  void fetchDevices() async {
    try {
      String? userUid = globalUid;
      String? documentId = await getDocumentNameByUserId(userUid);
      globalDocumentId = documentId;

      if (documentId != null) {
        List<String> devicesList = await getDevicesField(documentId);

        setState(() {
          devices = devicesList;
          isLoading = false;
        });

        print("Devices: $devicesList");
      } else {
        print("Document ID not found for the given UID.");
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching devices: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  void _fetchUserData() async {
    try {
      _user = _auth.currentUser;
      if (_user != null) {
        setState(() {
          _firstName = _user!.displayName?.split(' ')[0];
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _deleteDevice(String deviceName) async {
    try {
      String? documentId = globalDocumentId;
      if (documentId == null) {
        print("Global document ID is null.");
        return;
      }

      DocumentReference userDocRef =
          FirebaseFirestore.instance.collection('users').doc(documentId);

      // Get the current devices array
      DocumentSnapshot snapshot = await userDocRef.get();
      if (!snapshot.exists) {
        print("User document does not exist.");
        return;
      }

      List<dynamic> devicesList = snapshot.get('devices') ?? [];

      // Find the device object to remove
      Map<String, dynamic>? deviceToRemove;
      for (var device in devicesList) {
        if (device['name'] == deviceName) {
          deviceToRemove = device as Map<String, dynamic>;
          break;
        }
      }

      if (deviceToRemove == null) {
        print("Device not found in Firestore.");
        return;
      }

      // Remove the found device object from the array
      await userDocRef.update({
        'devices': FieldValue.arrayRemove([deviceToRemove]),
      });

      print("Device deleted successfully");

      // Refresh the UI by removing the device locally
      setState(() {
        devices.remove(deviceName);
      });
    } catch (e) {
      print("Error occurred while deleting device: $e");
    }
  }

  void _onDeviceCardTapped(String deviceName) async {
    try {
      String? documentId = globalDocumentId;
      if (documentId == null) {
        print("Global document ID is null.");
        return;
      }

      String? fetchedDeviceId = await getDeviceIdByName(documentId, deviceName);
      if (fetchedDeviceId != null) {
        setState(() {
          globalDeviceId = fetchedDeviceId;
        });

        print("Device ID for $deviceName: $globalDeviceId");

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } else {
        print("No device ID found for the device: $deviceName.");
      }
    } catch (e) {
      print("Error occurred while fetching device ID: $e");
    }
  }

  Widget _buildSystemCard(String systemName) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Color(0xFFF9FBFA),
      elevation: 0, // No shadow effect
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(), // Empty space for alignment
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete') {
                    _deleteDevice(systemName);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      "Delete Device",
                      style: GoogleFonts.poppins(),
                    ),
                  ),
                ],
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.more_vert, color: Colors.grey[500]),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.0075),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () => _onDeviceCardTapped(systemName),
              child: Text(
                systemName,
                style: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 16.0, top: 60, right: 16, left: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hii,',
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _firstName ?? '',
              style: GoogleFonts.poppins(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView(
                      children: [
                        ...devices.map((device) => _buildSystemCard(device)),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
