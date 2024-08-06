import 'package:flutter/material.dart';
import '../home_screen/home_page.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> allNames = [
    'Urban Eden',
    'Forest Glen',
    'Veggie Haven',
    'Gardenia',
    'Herb Hollow',
    'Ivy Nook'
  ];
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
      isNameAvailable = name.isNotEmpty && allNames.contains(name);
      if (name.isEmpty) {
        message = '';
      } else if (!isNameAvailable) {
        message = 'This name is already chosen or invalid.';
      } else {
        message = '';
      }
    });
  }

  void _onChipTap(String name) {
    setState(() {
      _controller.text = name;
      _checkNameAvailability(); // Update availability immediately
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

    if (!allNames.contains(name)) {
      setState(() {
        message = 'This name is already chosen or invalid.';
      });
    } else {
      setState(() {
        allNames.remove(name);
        message = 'Name set successfully!';
        _controller.clear();
      });
      // Navigate to the home page or next screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()), // Replace with your home page widget
      );
    }
  }

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
              SizedBox(height: h * 0.2),
              Text(
                'Name your system',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Text(
                'Name your XenBloom or use our suggestions. You can change it anytime.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: h * 0.03),
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Enter a name',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                      prefixIcon: Icon(Icons.account_circle_rounded, color: Colors.grey),
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide: BorderSide.none,
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
                children: allNames.map((name) {
                  return GestureDetector(
                    onTap: () => _onChipTap(name),
                    child: Chip(
                      label: Text(name),
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: Colors.transparent, width: 1),
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: h * 0.23),
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
    );
  }
}
