import 'package:flutter/material.dart';
import 'package:conditional_questions/conditional_questions.dart';

class QuestionsMauxScreen extends StatefulWidget {
  const QuestionsMauxScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _QuestionsMauxScreenState createState() => _QuestionsMauxScreenState();
}

class _QuestionsMauxScreenState extends State<QuestionsMauxScreen> {
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
          MaterialButton(
            color: Colors.deepOrange,
            splashColor: Colors.orangeAccent,
            onPressed: () async {
              if (_key.currentState != null && _key.currentState!.validate()) {
                // Check if _key.currentState is Nont null before calling validate()
                print("validee!");
              }
            },
            child: const Text("Envoyer"),
          )
        ],
        leading: const [Text("Questionnaire")],
      ),
    );
  }
}

List<Question> questions() {
  return [
    // Question 1
    Question(
      question:
          "Quelles sont les maladies que tu as subis ces derniers temps ? ",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Field canNont be empty";
        return null;
      },
    ),
    // question 2
    Question(
      question: "Qu'est-ce que tu as mis en place pour te soulager ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Field canNont be empty";
        return null;
      },
    ),
    // Question 3
    PolarQuestion(
        question:
            "Est-ce que j'ai vécu une situation émotionnellement éprouvante juste avant l'apparition des symptômes ?",
        answers: ["Oui", "Non"],
        isMandatory: true),
    // question 4
    PolarQuestion(
        question: "Quelle était cette situation ?", answers: ["Oui", "Non"]),
  ];
}
