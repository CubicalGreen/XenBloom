import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:convert';
import 'dart:io';
import 'globalVariable.dart';

class FirebaseServices{
  final auth  = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  final firebaseMessaging = FirebaseMessaging.instance;



   signinWithGoogle() async {
    try{

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if(googleSignInAccount !=null){
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        final AuthCredential authCredential  = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken
        );
        UserCredential userCredential =  await auth.signInWithCredential(authCredential);
        User? user = userCredential.user;
        print("=================================");
        if (user != null) {
          String uid = user.uid;
          globalUid = uid;
          print('User UID: $uid');

          // fcm token
          String? fcmToken = await firebaseMessaging.getToken();
          print('FCM Token: $fcmToken');

          print("=================================");
          sendUserDataToBackend(uid, fcmToken);

          return uid;
        }
      }
    } on FirebaseAuthException catch(e){
      print(e.toString());


    }


    return null;
  }
  // sending data to the actual backend this time fr
  Future<void> sendUserDataToBackend(String uid, String? fcmToken) async {
    final url = Uri.parse('https://us-central1-xen-bloom.cloudfunctions.net/addUser');  // Replace with your backend URL


    // Construct the JSON payload according to your user schema
    final payload = {
      'uid': uid,             // Use uid as userId
      'fcmToken': fcmToken,      // Include FCM token
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload),  // Convert the payload to JSON format
      );

      if (response.statusCode == 200) {
        print('User data sent to the backend successfully');
      }
      else if (response.statusCode == 409) {
        print('User already exists!');
      }
      else {
        print('Error sending data to backend: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  googleSignOut() async {
    await googleSignIn.signOut();
  }
}

