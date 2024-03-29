const functions = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');

admin.initializeApp();

exports.sendContactEmail = functions.firestore
  .document('contact/{documentId}')
  .onCreate((snapshot, context) => {
    const data = snapshot.data();

    // Email parameters
    const mailOptions = {
      from: 'YOUR_EMAIL_ADDRESS',
      to: 'elbah.ma02@gmail.com',
      //contact@kaisi.fr
      subject: 'New Contact Form Submission',
      text: `Name: ${data.name}\nEmail: ${data.email}\nMessage: ${data.message}`,
    };

    // Nodemailer transporter
    const transporter = nodemailer.createTransport({
      service: 'Gmail',
      auth: {
        user: 'YOUR_EMAIL_ADDRESS',
        pass: 'YOUR_EMAIL_PASSWORD',
      },
    });

    // Send email
    return transporter.sendMail(mailOptions, (error, info) => {
      if (error) {
        console.error('Error sending email:', error);
      } else {
        console.log('Email sent:', info.response);
      }
    });
  });