import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kaisi_app/utilities/Dialogs/message_dialog.dart';
// import 'package:kaisi_app/Screens/appbar/appbar.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  String _feedbackErrorText = '';
  String _nameErrorText = '';
  String _emailErrorText = '';

  Future<void> _submitForm() async {
    String message = _messageController.text.trim();
    String name = _nameController.text.trim();
    String email = _emailController.text.trim();

    if (message.isNotEmpty && name.isNotEmpty) {
      try {
        // Sending feedback to the backend
        await FirebaseFirestore.instance.collection('contact').add({
          'message': message,
          'name': name,
          'email': email,
          'timestamp': DateTime.now()
        });
        // Feedback submitted successfully
        _messageController.clear();
        _nameController.clear();
        _emailController.clear();

        messageDialog(context, 'Merci pour votre message, $name !');
      } catch (e) {
        print('Error submitting message: $e');
        // Handle error here
      }
    } else {
      setState(() {
        _feedbackErrorText =
            message.isEmpty ? 'Le message ne peut pas être vide"' : '';
        _nameErrorText = name.isEmpty ? 'Le nom ne peut pas être vide' : '';
        _emailErrorText = email.isEmpty ? "l'email ne peut pas être vide" : '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Adresse E-mail'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(labelText: 'Message'),
              maxLines: 5,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                // Validate form fields and submit data
                if (_validateForm()) {
                  _submitForm();
                }
              },
              child: const Text('Envoyer'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateForm() {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez remplir tous les champs.'),
        ),
      );
      return false;
    }
    return true;
  }
}
