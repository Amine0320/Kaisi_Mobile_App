import 'package:get/get.dart';

class SignupController extends GetxController {
  var firstName = ''.obs;
  var lastName = ''.obs;
  var email = ''.obs;
  var phoneNumber = ''.obs;

  void updateSignupInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
  }) {
    this.firstName.value = firstName;
    this.lastName.value = lastName;
    this.email.value = email;
    this.phoneNumber.value = phoneNumber;
  }
}
