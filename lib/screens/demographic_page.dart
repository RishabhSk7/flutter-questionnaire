import 'package:flutter/material.dart';
import 'package:questionnairev2/screens/emotion_questionnaire_page.dart';

class DemographicPage extends StatefulWidget {
  @override
  _DemographicPageState createState() => _DemographicPageState();
}

class _DemographicPageState extends State<DemographicPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  int? _age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demographic Information'),
        actions: [
          IconButton(
            icon: Icon(Icons.admin_panel_settings_rounded),
            onPressed: () {
              Navigator.pushNamed(context, '/admin');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Age (10-100)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Validate and proceed to the next page
                if (_ageController.text.isNotEmpty) {
                  _age = int.tryParse(_ageController.text);
                  if (_age != null && _age! >= 10 && _age! <= 100) {
                    // Proceed to the emotion questionnaire page
                    Navigator.pushNamed(context, "/emotions");
                  } else {
                    // Show error message
                    _showErrorDialog(
                        'Please enter a valid age between 10 and 100.');
                  }
                }
              },
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
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
