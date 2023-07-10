import 'package:flutter/material.dart';
import 'result_screen.dart';

class QuestionScreen extends StatefulWidget {
  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  int _currentQuestionIndex = 0;
  List<String> _questions = [
    'What is the capital of France?',
    'Who painted the Mona Lisa?',
    'What is the largest planet in our solar system?',
    'What is the tallest mountain in the world?',
    'Which country is known for Bollywood movies?'
  ];
  List<List<String>> _choices = [
    ['Paris', 'London', 'Berlin', 'Rome'],
    ['Leonardo da Vinci', 'Pablo Picasso', 'Vincent van Gogh', 'Michelangelo'],
    ['Jupiter', 'Saturn', 'Mars', 'Earth'],
    ['Mount Kilimanjaro', 'Mount Everest', 'K2', 'Mount Fuji'],
    ['India', 'China', 'United States', 'Japan']
  ];
  List<int> _correctAnswers = [0, 0, 0, 1, 0];
  List<int?> _selectedAnswers = [null, null, null, null, null];

  void _selectAnswer(int questionIndex, int choiceIndex) {
    setState(() {
      _selectedAnswers[questionIndex] = choiceIndex;
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ResultScreen(
            questions: _questions,
            choices: _choices,
            correctAnswers: _correctAnswers,
            selectedAnswers: _selectedAnswers,
          ),
        ),
      );
    }
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Question ${_currentQuestionIndex + 1}:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _questions[_currentQuestionIndex],
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Column(
              children: List<Widget>.generate(_choices[_currentQuestionIndex].length, (index) {
                final choice = _choices[_currentQuestionIndex][index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: RadioListTile<int>(
                    title: Text(
                      choice,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    value: index,
                    groupValue: _selectedAnswers[_currentQuestionIndex],
                    onChanged: (value) {
                      _selectAnswer(_currentQuestionIndex, value!);
                    },
                    activeColor: Colors.indigo,
                    tileColor: Colors.grey[200],
                    controlAffinity: ListTileControlAffinity.leading,
                  ),
                );
              }),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _currentQuestionIndex > 0 ? _previousQuestion : null,
                  child: Text('Previous'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _selectedAnswers[_currentQuestionIndex] == null ? null : _nextQuestion,
                  child: Text('Next'),
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
          ],
        ),
      ),
    );
  }
}
