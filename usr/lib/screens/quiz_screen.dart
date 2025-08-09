import 'package:flutter/material.dart';
import '../data/questions.dart';
import '../models/question.dart';
import 'result_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;

  void _answerQuestion(int selectedOptionIndex) {
    if (selectedOptionIndex == questions[_currentQuestionIndex].correctAnswerIndex) {
      _score++;
    }

    setState(() {
      if (_currentQuestionIndex < questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        // Go to result screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(
              score: _score,
              totalQuestions: questions.length,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Question currentQuestion = questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: Text('Soal ${_currentQuestionIndex + 1}/${questions.length}'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion.questionText,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...List.generate(currentQuestion.options.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: () => _answerQuestion(index),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.blueAccent),
                    ),
                  ),
                  child: Text(currentQuestion.options[index]),
                ),
              );
            }),
            const Spacer(),
            Text(
              'Skor: $_score',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
