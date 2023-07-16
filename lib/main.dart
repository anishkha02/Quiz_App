import 'package:flutter/material.dart';

void main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  List<Map<String, dynamic>> _questions = [
    {
      'question': 'What is the capital of France?',
      'options': ['Berlin', 'London', 'Paris', 'Madrid'],
      'correctAnswer': 'Paris',
    },
    {
      'question': 'Which planet is known as the Red Planet?',
      'options': ['Mars', 'Venus', 'Jupiter', 'Saturn'],
      'correctAnswer': 'Mars',
    },
    {
      'question': 'What is the largest mammal on Earth?',
      'options': ['Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus'],
      'correctAnswer': 'Blue Whale',
    },
    {
      'question': 'Who painted the Mona Lisa?',
      'options': ['Vincent van Gogh', 'Pablo Picasso', 'Leonardo da Vinci', 'Michelangelo'],
      'correctAnswer': 'Leonardo da Vinci',
    },
    {
      'question': 'Which country is known as the Land of the Rising Sun?',
      'options': ['China', 'Japan', 'South Korea', 'Thailand'],
      'correctAnswer': 'Japan',
    },
  ];

  void _checkAnswer(String selectedAnswer) {
    String correctAnswer = _questions[_currentQuestionIndex]['correctAnswer'];

    if (selectedAnswer == correctAnswer) {
      setState(() {
        _score++;
      });
    }

    _nextQuestion();
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      // Quiz Completed, Show Results
      _showResultDialog();
    }
  }

  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0;
      _score = 0;
    });
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed'),
          content: Text('You scored $_score out of ${_questions.length}'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartQuiz();
              },
              child: Text('Restart Quiz'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (_currentQuestionIndex + 1) / _questions.length,
              backgroundColor: Colors.grey[300],
              minHeight: 10,

              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
            SizedBox(height: 16.0),
            Text(
              'Question ${_currentQuestionIndex + 1}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8.0),
            Text(
              _questions[_currentQuestionIndex]['question'],
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16.0),
            ...(_questions[_currentQuestionIndex]['options'] as List<String>)
                .map(
                  (option) => ElevatedButton(
                onPressed: () => _checkAnswer(option),
                child: Text(option),
              ),
            )
                .toList(),
          ],
        ),
      ),
    );
  }
}
