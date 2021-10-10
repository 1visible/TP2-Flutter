import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'question.dart';

class QuestionProvider extends ChangeNotifier {
  final List<Question> _questions = [
    Question(
        questionText: "Le cri des lions peut être entendu à plus de 8 km.",
        isCorrect: true,
        imagePath: "images/img_1.jpg"),
    Question(
        questionText:
            "Chez les zèbres, les jeunes étalons fondent leur famille vers l’âge de 4 ou 5 ans.",
        isCorrect: true,
        imagePath: "images/img_2.jpg"),
    Question(
        questionText: "Seule la femelle du marabout couve les oeufs. ",
        isCorrect: false,
        imagePath: "images/img_3.jpg"),
    Question(
        questionText: "La corne des rhinocéros est faite de kératine.",
        isCorrect: true,
        imagePath: "images/img_4.jpg"),
    Question(
        questionText:
            "La trompe de l’éléphant d’Afrique est constituée de 145 os.",
        isCorrect: false,
        imagePath: "images/img_5.jpg"),
    Question(
        questionText:
            "Quand elle est ouverte, la gueule des hippopotames forme un angle droit (90 degrés).",
        isCorrect: false,
        imagePath: "images/img_6.jpg"),
    Question(
        questionText:
            "Chaque année, les gnous migrent sur une distance d’environ 850 km.",
        isCorrect: false,
        imagePath: "images/img_7.jpg"),
    Question(
        questionText:
            "Le buffle d’Afrique peut courir à une vitesse d’environ 57 km/h.",
        isCorrect: true,
        imagePath: "images/img_8.jpg"),
    Question(
        questionText:
            "Le lycaon est nomade seulement lors de la période de reproduction.",
        isCorrect: false,
        imagePath: "images/img_9.jpg"),
    Question(
        questionText:
            "Les petits du chacal à chabraque sont plus pâles que les adultes.",
        isCorrect: false,
        imagePath: "images/img_10.jpg")
  ];
  bool _isEnabled = true;
  int _counter = 0;
  int _questionNumber = 0;
  late Question _question;

  List<Question> get questions => _questions;
  bool get isEnabled => _isEnabled;
  int get counter => _counter;
  int get questionNumber => _questionNumber;
  Question get question => _question;

  QuestionProvider() {
    _question = _questions[_questionNumber];
  }

  checkAnswer(bool userChoice, BuildContext context) {
    String text;
    Color color;

    if (_question.isCorrect == userChoice) {
      text = 'Vous avez la bonne réponse !';
      color = Colors.green.shade900;
      _counter++;
      notifyListeners();
    } else {
      text = 'Vous vous êtes trompé(e)...';
      color = Colors.red.shade900;
    }

    final snackBar = SnackBar(
        content: Text(text),
        backgroundColor: color,
        duration: const Duration(milliseconds: 500));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    nextQuestion();
  }

  nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
      _question = _questions[_questionNumber];
    } else {
      _isEnabled = false;
    }
    notifyListeners();
  }
}
