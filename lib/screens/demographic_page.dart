import 'package:flutter/material.dart';
import 'package:questionnairev2/models/user_model.dart';

class DemographicPage extends StatefulWidget {
  @override
  _DemographicPageState createState() => _DemographicPageState();
}

class _DemographicPageState extends State<DemographicPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Demographic Information',
          style: TextStyle(
            color: Colors.deepPurple,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.admin_panel_settings_rounded),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  final TextEditingController pinController =
                      TextEditingController();
                  const String hardcodedPin = "1997";

                  return AlertDialog(
                    title: Text('Enter Admin PIN'),
                    content: TextField(
                      controller: pinController,
                      keyboardType: TextInputType.number,
                      obscureText: true, // Hides the input for security
                      decoration: InputDecoration(
                        labelText: 'PIN',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (pinController.text == hardcodedPin) {
                            Navigator.pop(context); // Close the dialog
                            Navigator.pushNamed(
                                context, '/admin'); // Navigate to /admin
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Incorrect PIN!'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF8F3FF), // Light pinkish background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            width: 350,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _validateInputs,
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Age (10-100)',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _validateInputs,
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isButtonEnabled
                        ? Colors.deepPurple
                        : Colors.deepPurple.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: isButtonEnabled
                      ? () {
                          final age = int.tryParse(_ageController.text);
                          if (age != null && age >= 10 && age <= 100) {
                            Navigator.pushNamed(
                              context,
                              "/emotions",
                              arguments: User(
                                name: _nameController.text,
                                age: age,
                              ),
                            );
                          } else {
                            _showErrorDialog(
                              'Please enter a valid age between 10 and 100.',
                            );
                          }
                        }
                      : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Next',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color:
                                isButtonEnabled ? Colors.white : Colors.grey),
                      ),
                      Icon(Icons.arrow_forward_rounded,
                          color: isButtonEnabled ? Colors.white : Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _validateInputs(String value) {
    final isNameValid = _nameController.text.isNotEmpty;
    final isAgeValid = int.tryParse(_ageController.text) != null &&
        int.parse(_ageController.text) >= 10 &&
        int.parse(_ageController.text) <= 100;

    setState(() {
      isButtonEnabled = isNameValid && isAgeValid;
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
