import 'package:flutter/material.dart';
import 'package:conditional_questions/conditional_questions.dart';

class QuestionsPAScreen extends StatefulWidget {
  const QuestionsPAScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _QuestionsPAScreenState createState() => _QuestionsPAScreenState();
}

class _QuestionsPAScreenState extends State<QuestionsPAScreen> {
  final _key = GlobalKey<QuestionFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ??
            'Questions'), // Use a default title if widget.title is null
      ),
      body: ConditionalQuestions(
        key: _key,
        children: questions(),
        trailing: [
          ElevatedButton(
            onPressed: () async {
              if (_key.currentState != null && _key.currentState!.validate()) {
                // Check if _key.currentState is Nont null before calling validate()
                print("validee!");
              }
            },
            child: const Text('Envoyer'),
          ),
        ],
        leading: const [Text("TITLE")],
      ),
    );
  }
}

List<Question> questions() {
  return [
    Question(
      question: "What is your name?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Field cannot be empty";
        return null;
      },
    ),
    PolarQuestion(
        question: "Have you made any donations in the past?",
        answers: ["Yes", "No"],
        isMandatory: true),
    PolarQuestion(
        question: "In the last 3 months have you had a vaccination?",
        answers: ["Yes", "No"]),
    PolarQuestion(
        question: "Have you ever taken medication for HIV?",
        answers: ["Yes", "No"]),
    NestedQuestion(
      question: "The series will depend on your answer",
      answers: ["Yes", "No"],
      children: {
        'Yes': [
          PolarQuestion(
              question: "Have you ever taken medication for H1n1?",
              answers: ["Yes", "No"]),
          PolarQuestion(
              question: "Have you ever taken medication for Rabies?",
              answers: ["Yes", "No"]),
          Question(
            question: "Comments",
          ),
        ],
        'No': [
          NestedQuestion(
              question: "Have you sustained any injuries?",
              answers: [
                "Yes",
                "No"
              ],
              children: {
                'Yes': [
                  PolarQuestion(
                      question: "Did it result in a disability?",
                      answers: ["Yes", "No", "I prefer not to say"]),
                ],
                'No': [
                  PolarQuestion(
                      question: "Have you ever been infected with chicken pox?",
                      answers: ["Yes", "No"]),
                ]
              }),
        ],
      },
    )
  ];
}
