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
                // Check if _key.currentState is Nonnt null before calling validate()
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
      question: "Quel est votre objectif ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 2
    Question(
      question: "Pourquoi cet objectif est-il important pour vous ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 3
    Question(
      question: "Dans quel délai envisagez-vous de réaliser cet objectif ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 4
    Question(
      question:
          "Quelles sont les principales limites qui vous empêchent d'atteindre votre objectif ? Expliquez.",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 5
    Question(
      question:
          "Quelles améliorations ou apprentissages pourriez-vous envisager pour surmonter ces obstacles ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 6
    Question(
      question:
          "De quels moyens (ressources, outils, compétences) aurez-vous besoin pour surmonter ces obstacles ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 7
    Question(
      question:
          "Qui pourrait vous accompagner ou vous soutenir dans cette démarche ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 8
    Question(
      question:
          "Quelle est la première action concrète à mettre en place pour réduire ces limites ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 9
    Question(
      question:
          "Quelle est la principale raison qui vous pousse à réaliser cet objectif ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 10
    Question(
      question: "Quels bénéfices attendez-vous pour atteindre cet objectif ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 11
    Question(
      question:
          "Quelles ressources considérez-vous utiles pour la réalisation de votre objectif ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 12
    Question(
      question:
          "Si vous avez déjà atteint votre objectif, que ressentez-vous ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 13
    Question(
      question: "Où seriez-vous ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 14
    Question(
      question:
          "Que feriez-vous ce jour-là ? Décrivez l'environnement, la décoration, le temps et l'atmosphère.",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 15
    Question(
      question:
          "Après avoir réalisé votre objectif, qu'est-ce que cela évoque pour vous ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 16
    Question(
      question:
          "Imaginez avoir réussi à réaliser votre objectif. Quelles étaient les étapes franchisées ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 17
    Question(
      question:
          "Pourriez-vous réfléchir aux tâches nécessaires à la réalisation de chaque étape ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 18
    Question(
      question: "Combien de temps estimez-vous nécessaire pour chaque étape ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 19
    Question(
      question:
          "Combien de temps êtes-vous prêt à consacrer à la réalisation de cet objectif ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 20
    Question(
      question:
          "Sur une échelle de 1 à 10, à quel point êtes-vous engagé(e) à réaliser cet objectif ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 21
    Question(
      question:
          "Comment priorisez-vous ce projet par rapport à vos autres engagements et responsabilités  de 1 à10 ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 22
    Question(
      question:
          "Avez-vous identifié des personnes de votre entourage (amis, famille, collègues) susceptibles de vous soutenir dans votre démarche ? Comment peuvent-elles vous aider ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 23
    Question(
      question:
          "Existe-t-il des groupes, des communautés, des associations ou des professionnels spécialisés pouvant vous apporter un soutien ou des conseils supplémentaires ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 24
    Question(
      question:
          "Comment envisagez-vous de suivre vos progrès ? Avez-vous un système ou un outil en place pour cela ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 25
    Question(
      question:
          "Comment réagirez-vous face aux obstacles imprévus ou aux changements de situation ? Avez-vous un plan pour ajuster vos stratégies si nécessaire ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 26
    Question(
      question:
          "Qu'est-ce qui, dans votre passé, vous a prouvé que vous êtes capable d'atteindre des objectifs similaires ou de relever des défis de cette nature ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 27
    Question(
      question:
          "Comment cet objectif s'inscrit-il dans votre parcours personnel ou professionnel à long terme ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 28
    Question(
      question:
          "Quelle est la chose la plus importante que vous ayez informée sur vous-même en répondant à ce questionnaire ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
    //Question 29
    Question(
      question:
          "Quelles sont les trois nouvelles actions concrètes que vous comptez entreprendre pour avancer vers votre objectif ?",
      //isMandatory: true,
      validate: (field) {
        if (field.isEmpty) return "Champ ne peut pas être vide.";
        return null;
      },
    ),
  ];
}
