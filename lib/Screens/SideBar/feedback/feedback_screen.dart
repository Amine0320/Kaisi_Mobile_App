import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kaisi_app/Screens/HomeScreen/Components/app_theme.dart';
import 'package:kaisi_app/utilities/Dialogs/feedBack_dialog.dart';

class FeedbackScreen extends StatefulWidget {
  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _feedbackErrorText = '';
  String _nameErrorText = '';
  @override
  void initState() {
    super.initState();
  }

  Future<void> _submitFeedback() async {
    String feedback = _feedbackController.text.trim();
    String name = _nameController.text.trim();

    if (feedback.isNotEmpty && name.isNotEmpty) {
      try {
        // Sending feedback to the backend
        await FirebaseFirestore.instance.collection('feedback').add(
            {'feedback': feedback, 'name': name, 'timestamp': DateTime.now()});
        // Feedback submitted successfully
        _feedbackController.clear();
        _nameController.clear();

        feedBackDialog(context, 'Merci pour votre retour, $name !');
      } catch (e) {
        print('Error submitting feedback: $e');
        // Handle error here
      }
    } else {
      setState(() {
        _feedbackErrorText =
            feedback.isEmpty ? 'Le feedback ne peut pas être vide"' : '';
        _nameErrorText = name.isEmpty ? 'Le nom ne peut pas être vide' : '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;
    return Container(
      color: isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor:
              isLightMode ? AppTheme.nearlyWhite : AppTheme.nearlyBlack,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).padding.top,
                        left: 16,
                        right: 16),
                    child:
                        Image.asset('assets/SideBarImages/feedbackImage.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "Votre retour d'information",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: isLightMode ? Colors.black : Colors.white),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      'Donnez votre meilleur temps pour ce moment.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16,
                          color: isLightMode ? Colors.black : Colors.white),
                    ),
                  ),
                  _buildComposer(),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Center(
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isLightMode ? Colors.blue : Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.6),
                                offset: const Offset(4, 4),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: TextButton(
                                  // Do the logic for the button to send the feedback to the contact@kaisi.fr
                                  onPressed: _submitFeedback,
                                  style: TextButton.styleFrom(
                                    textStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: isLightMode
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  child: const Text('Envoyer'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComposer() {
    return Padding(
      padding: const EdgeInsets.only(top: 16, left: 32, right: 32),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.grey.withOpacity(0.8),
                offset: const Offset(4, 4),
                blurRadius: 8),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Container(
            padding: const EdgeInsets.all(4.0),
            constraints: const BoxConstraints(minHeight: 120, maxHeight: 200),
            color: AppTheme.white,
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
              child: Column(
                children: [
                  TextField(
                    controller: _nameController,
                    maxLines: null,
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontSize: 16,
                      color: AppTheme.dark_grey,
                    ),
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Votre Nom',
                    ),
                  ),
                  const SizedBox(
                      height: 10), // Add some space between the text fields
                  TextField(
                    controller: _feedbackController,
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontFamily: AppTheme.fontName,
                      fontSize: 16,
                      color: AppTheme.dark_grey,
                    ),
                    cursorColor: Colors.blue,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Veuillez saisir votre commentaire...',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
