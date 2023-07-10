import 'package:flutter/material.dart';
import 'question_screen.dart';

class ResultScreen extends StatelessWidget {
  final List<String> questions;
  final List<List<String>> choices;
  final List<int> correctAnswers;
  final List<int?> selectedAnswers;

  ResultScreen({
    required this.questions,
    required this.choices,
    required this.correctAnswers,
    required this.selectedAnswers,
  });

  @override
  Widget build(BuildContext context) {
    int score = 0;
    List<String> answerResults = [];

    for (int i = 0; i < questions.length; i++) {
      String answerStatus = selectedAnswers[i] == correctAnswers[i] ? 'Correct' : 'Incorrect';
      answerResults.add("Question ${i + 1}: ${choices[i][correctAnswers[i]]} - $answerStatus");
      if (selectedAnswers[i] == correctAnswers[i]) {
        score++;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Result'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Quiz Completed'),
            SizedBox(height: 16),
            Text('Your Score: $score/${questions.length}'),
            SizedBox(height: 16),
            Text('Answer Results:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: answerResults.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(answerResults[index]),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
