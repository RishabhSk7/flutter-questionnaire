import 'package:flutter/material.dart';
import 'package:questionnairev2/core/database_helper.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final List<String> questions = [];
  final TextEditingController questionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void addQuestion() async {
    if (questionController.text.isNotEmpty) {
      await DatabaseHelper.instance.insertQuestion(questionController.text);
      _loadQuestions();
      questionController.clear();
    }
  }

  void removeQuestion(String question) async {
    await DatabaseHelper.instance
        .deleteQuestion(question); // Delete by question text
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    final questionList = await DatabaseHelper.instance.getQuestions();
    setState(() {
      questions.clear();
      questions.addAll(questionList.map((q) => q['question'] as String));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                labelText: 'Question',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: addQuestion,
              child: Text('Add Question'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(questions[index]),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => removeQuestion(questions[index]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
