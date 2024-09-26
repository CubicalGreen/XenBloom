import 'package:flutter/material.dart';

import '../Elements/customTextfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 18,right: 18,top: h*0.18,bottom: h*0.02),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              CustomTextfield(labelText: 'Email', icon: Icons.email_outlined),
              SizedBox(height: 20),
              CustomTextfield(labelText: 'Password', icon: Icons.lock_outline),
              SizedBox(height: 20),
              CustomTextfield(labelText: 'Confirm Password', icon: Icons.lock_outline),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(value: _isChecked, onChanged: (bool? value) {
                    setState(() {
                      _isChecked = value ?? false;
                    });
                  },
                    activeColor:Color.fromRGBO(117, 214, 178, 1),),
                  RichText(
                    text: TextSpan(
                      text: 'I accept the ',
                      style: TextStyle(color: Colors.black,fontSize: 15),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'terms',
                          style: TextStyle(color: Color.fromRGBO(117, 214, 178, 1),fontSize: 15),
                        ),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.black,fontSize: 15),
                        ),
                        TextSpan(
                          text: 'privacy policy',
                          style: TextStyle(color: Color.fromRGBO(117, 214, 178, 1),fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: h*0.01),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Sign Up',style: TextStyle(fontSize: 19),),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 36,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('Or continue with',style: TextStyle(color: Colors.grey),),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.grey,
                      height: 36,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: Image.asset(
                    'assets/images/Google.png',
                    height: 24.0,
                    width: 24.0,
                  ),

                  label: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      'Google',
                      style: TextStyle(fontSize: 19),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                ),
              ),


              SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(color: Colors.grey,fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(color: Colors.black,fontSize: 16,decoration: TextDecoration.underline),
                        ),
                      ],
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
