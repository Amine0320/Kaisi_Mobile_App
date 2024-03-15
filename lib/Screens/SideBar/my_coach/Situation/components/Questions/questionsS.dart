import 'package:flutter/material.dart';
import 'package:conditional_questions/conditional_questions.dart';

class QuestionsSituationScreen extends StatefulWidget {
  const QuestionsSituationScreen({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _QuestionsSituationScreenState createState() =>
      _QuestionsSituationScreenState();
}

class _QuestionsSituationScreenState extends State<QuestionsSituationScreen> {
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
        leading: const [Text("Questionnaire")],
      ),
    );
  }
}

List<Question> questions() {
  return [
    //Question 1
    Question(
      question: "Je décris la situation que je souhaite travailler ",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Le champ ne peut pas être vide";
        return null;
      },
    ),
    //question 2
    PolarQuestion(
        question: "Comment j’évalue cette situation ?",
        answers: [
          "L’injustice",
          "La trahison",
          "Le rejet",
          "L’humuliation ",
          "L’abandon",
        ],
        isMandatory: true),
    //Question 3
    Question(
      question: "Qu’est ce que cela m’évoque ? ",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Le champ ne peut pas être vide";
        return null;
      },
    ),
    //question 4
    PolarQuestion(
        question:
            "Si je Nonmme l'émotion que je traverse dans cette situation, ça serait ?",
        answers: [
          "Colère",
          "Dégout",
          "Tristresse",
          "Peur",
          "Honte",
          "Joie",
        ]),
    //Question 5
    NestedQuestion(
        question: "Dans cette situation, quel est mon besoin ? ",
        answers: [
          "Reconnaissance",
          "Lien",
          "Sécurité",
          "Compassion",
          "Attention",
          "Autre",
        ],
        children: {
          'Autre': [
            Question(
              question: "Vous pouvez decrire le besoin",
              //isMandatory: true,
              validate: (field) {
                if (field.isEmpty) return "Le champ ne peut pas être vide";
                return null;
              },
            ),
          ],
        }),
    //Question 6
    NestedQuestion(
        question:
            "Est ce que dans le passé, j’ai été affronté à une situation similaire ",
        answers: [
          "Oui",
          "Non"
        ],
        children: {
          'Oui': [
            Question(
              question: "Vous pouvez decrire la situation ? ",
              //isMandatory: true,
              validate: (field) {
                if (field.isEmpty) return "Le champ ne peut pas être vide";
                return null;
              },
            ),
          ],
          'Non': [
            Question(
              question: "Vous pouvez decrire la situation ?",
              //isMandatory: true,
              validate: (field) {
                if (field.isEmpty) return "Le champ ne peut pas être vide";
                return null;
              },
            ),
          ],
        }),
  ];
}
