// import 'package:flutter/material.dart';
// import 'package:kaisi_app/Screens/HomeScreen/Components/responsive.dart';
// import 'package:kaisi_app/Screens/SideBar/my_coach/Situation/components/Questions/questions.dart';
// import 'package:kaisi_app/Screens/SideBar/my_coach/Situation/components/situation_image.dart';
// // import 'package:kaisi_app/Screens/SideBar/my_coach/Situation/components/situation_form.dart';
// import 'package:kaisi_app/Screens/components/background.dart';
// // import 'components/situation_image.dart';

// class SituationScreen extends StatelessWidget {
//   const SituationScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Background(
//       child: SingleChildScrollView(
//         child: Responsive(
//           mobile: MobileSituationScreen(),
//           desktop: Row(
//             children: [
//               Expanded(
//                 child: SituationScreenImage(),
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SizedBox(
//                       width: 450,
//                       child: QuestionsScreen(),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class MobileSituationScreen extends StatelessWidget {
//   const MobileSituationScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return const Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: <Widget>[
//         SituationScreenImage(),
//         Row(
//           children: [
//             Spacer(),
//             Expanded(
//               flex: 8,
//               child: QuestionsScreen(),
//             ),
//             Spacer(),
//           ],
//         ),
//       ],
//     );
//   }
// }
