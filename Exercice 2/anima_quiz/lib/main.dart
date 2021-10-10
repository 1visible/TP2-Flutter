import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'container.dart';
import 'cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Questions/Réponses',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: BlocProvider(
        child: const MyQuizPage(title: 'Questions/Réponses'),
        create: (_) => QuestionCubit(),
      ),
    );
  }
}

class MyQuizPage extends StatelessWidget {
  const MyQuizPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(title),
        ),
        backgroundColor: Colors.blueGrey,
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 2.5,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: BlocBuilder<QuestionCubit, QuestionContainer>(
                      builder: (context, container) =>
                          Image.asset(container.question.imagePath),
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white54),
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: BlocBuilder<QuestionCubit, QuestionContainer>(
                  builder: (context, container) => Text(
                    container.question.questionText,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    BlocBuilder<QuestionCubit, QuestionContainer>(
                        builder: (context, container) {
                      if (container.isEnabled) {
                        return ElevatedButton(
                          onPressed: () {
                            if (container.isEnabled) {
                              context
                                  .read<QuestionCubit>()
                                  .checkAnswer(true, context);
                            }
                          },
                          child: const Text('VRAI'),
                        );
                      }
                      return const SizedBox(width: 0, height: 0);
                    }),
                    BlocBuilder<QuestionCubit, QuestionContainer>(
                        builder: (context, container) {
                      if (container.isEnabled) {
                        return ElevatedButton(
                          onPressed: () {
                            if (container.isEnabled) {
                              context
                                  .read<QuestionCubit>()
                                  .checkAnswer(false, context);
                            }
                          },
                          child: const Text('FAUX'),
                        );
                      }
                      return const Text("Merci d'avoir joué à AnimaQuiz !",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ));
                    }),
                    BlocBuilder<QuestionCubit, QuestionContainer>(
                        builder: (context, container) {
                      if (container.isEnabled) {
                        return ElevatedButton(
                          onPressed: () {
                            if (container.isEnabled) {
                              context.read<QuestionCubit>().nextQuestion();
                            }
                          },
                          child: const Icon(Icons.arrow_right_alt),
                        );
                      }
                      return const SizedBox(width: 0, height: 0);
                    }),
                  ]),
              BlocBuilder<QuestionCubit, QuestionContainer>(
                  builder: (context, container) =>
                      Text('Bonnes réponses : ${container.counter}/10',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ))),
            ]));
  }
}
