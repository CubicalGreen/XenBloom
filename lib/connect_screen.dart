import 'package:flutter/material.dart';

import 'features/Elements/customTextfield.dart';
import 'features/other_screens/name_screen.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({super.key});

  @override
  State<ConnectScreen> createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h*0.2),
              Text(
                'Connect XenBloom!',
                style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),
              ),
              Text(
                'We would love to have your name and phone number to add a personal touch',
                style: TextStyle(fontSize: 16,color: Colors.grey),
              ),
              SizedBox(height: h*0.03,),
              CustomTextfield(labelText: 'Wi-fi SSID', icon: Icons.wifi),
              SizedBox(height: h*0.03,),
              CustomTextfield(labelText: 'Wi-fi Passkey', icon: Icons.vpn_key_sharp),
              SizedBox(height: h*0.35,),
              Center(
                child: SizedBox(
                  width: w * 0.9,
                  height:h * 0.07,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NameScreen()), // Navigate to the ConnectScreen
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: Text('Continue',style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                )
        
              ),
            ],
          ),
        ),
      ),
    );
  }
}
