import 'package:flutter/material.dart';
import 'package:questionnairev2/models/user_model.dart';

class DemographicPage extends StatefulWidget {
  @override
  _DemographicPageState createState() => _DemographicPageState();
}

class _DemographicPageState extends State<DemographicPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _educationController = TextEditingController();
  bool? _autismSpectrumAnswer;
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
                      obscureText: true,
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
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/admin');
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
      backgroundColor: const Color(0xFFF8F3FF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
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
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _genderController.text.isEmpty
                      ? null
                      : _genderController.text,
                  items: const [
                    DropdownMenuItem<String>(
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Female',
                      child: Text('Female'),
                    ),
                    DropdownMenuItem<String>(
                      value: 'Other',
                      child: Text('Other'),
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      _genderController.text = newValue ?? '';
                    });
                    _validateInputs('');
                  },
                ),
                SizedBox(height: 16),
                TextField(
                  controller: _educationController,
                  decoration: InputDecoration(
                    labelText: 'Education',
                    labelStyle: TextStyle(color: Colors.grey[700]),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: _validateInputs,
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<bool>(
                  value: _autismSpectrumAnswer,
                  items: const [
                    DropdownMenuItem<bool>(
                      value: true,
                      child: Text('Yes'),
                    ),
                    DropdownMenuItem<bool>(
                      value: false,
                      child: Text('No'),
                    ),
                  ],
                  decoration: InputDecoration(
                    labelText: 'Do you lie in the autism spectrum?',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (bool? newValue) {
                    setState(() {
                      _autismSpectrumAnswer = newValue;
                    });
                    _validateInputs('');
                  },
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
                            Navigator.pushNamed(context, "/emotions",
                                arguments: User(
                                  name: _nameController.text,
                                  age: age,
                                  education: _educationController.text,
                                  gender: _genderController.text,
                                  autismSpectrum: _autismSpectrumAnswer!,
                                ));
                            setState(() {
                              _nameController.clear();
                              _ageController.clear();
                              _genderController.clear();
                              _educationController.clear();
                              _autismSpectrumAnswer = null;
                              isButtonEnabled = false;
                            });
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
    final isGenderValid = _genderController.text.isNotEmpty;
    final isEducationValid = _educationController.text.isNotEmpty;
    final isAutismSpectrumValid = _autismSpectrumAnswer != null;

    setState(() {
      isButtonEnabled = isNameValid &&
          isAgeValid &&
          isGenderValid &&
          isEducationValid &&
          isAutismSpectrumValid;
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
