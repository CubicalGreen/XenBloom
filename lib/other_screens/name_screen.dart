import 'package:flutter/material.dart';
import '../home_screen/home_page.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _controller = TextEditingController();
  final Set<String> allNames = {
    'Urban Eden',
    'Forest Glen',
    'Veggie Haven',
    'Gardenia',
    'Herb Hollow',
    'Ivy Nook'
  };
  bool isNameAvailable = true;
  String message = '';

  @override
  void initState() {
    super.initState();
    _controller.text = 'Green Oasis'; // Default name
    _controller.addListener(_checkNameAvailability);
  }

  @override
  void dispose() {
    _controller.removeListener(_checkNameAvailability);
    _controller.dispose();
    super.dispose();
  }

  void _checkNameAvailability() {
    setState(() {
      final name = _controller.text.trim();
      isNameAvailable = name.isNotEmpty && !allNames.contains(name);
      message = _getMessage(name);
    });
  }

  String _getMessage(String name) {
    if (name.isEmpty) return '';
    if (!isNameAvailable) return 'This name is already chosen or invalid.';
    return '';
  }

  void _onChipTap(String name) {
    setState(() {
      _controller.text = name;
    });
  }

  void _onContinue() {
    final name = _controller.text.trim();

    if (name.isEmpty) {
      setState(() {
        message = 'Please enter a name.';
      });
      return;
    }

    if (!isNameAvailable) {
      setState(() {
        message = 'This name is already chosen or invalid.';
      });
      return;
    }

    // Perform further actions like navigating to the next screen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), // Replace with your home page widget
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Determine if keyboard is visible
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 18.0,
              right: 18.0,
              top: 18.0,
              bottom: isKeyboardVisible ? MediaQuery.of(context).viewInsets.bottom : 18.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isKeyboardVisible ? h * 0.1 : h * 0.1),
                Text(
                  'Name your system',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Name your XenBloom or use our suggestions. You can change it anytime.',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                SizedBox(height: h * 0.03),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      height: h * 0.065,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Enter a name',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    if (_controller.text.isNotEmpty)
                      Icon(
                        isNameAvailable ? Icons.check_circle_outline_sharp : Icons.error,
                        color: isNameAvailable ? Colors.green : Colors.red,
                      ),
                  ],
                ),
                if (message.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      message,
                      style: TextStyle(color: isNameAvailable ? Colors.green : Colors.red),
                    ),
                  ),
                SizedBox(height: h * 0.03),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0, // Add runSpacing to control vertical spacing
                  children: allNames.map((name) {
                    return GestureDetector(
                      onTap: () => _onChipTap(name),
                      child: Chip(
                        label: Text(
                          name,
                          style: TextStyle(fontSize: 12), // Reduce font size
                        ),
                        backgroundColor: Colors.grey.shade100,
                        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0), // Reduce padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.transparent, width: 1),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: isKeyboardVisible ? h * 0.03 : h * 0.42),
                SizedBox(
                  width: w * 0.9,
                  height: h * 0.07,
                  child: ElevatedButton(
                    onPressed: _onContinue,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
