import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kaisi_app/Screens/appbar/appbar.dart';
import 'package:kaisi_app/utilities/Validators/validation.dart';
import 'package:kaisi_app/controllers/update_name_controller.dart';
import 'package:kaisi_app/utilities/constants/sizes.dart';
import 'package:kaisi_app/utilities/constants/text_strings.dart';

class ChangeName extends StatelessWidget {
  const ChangeName({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateNameController());
    return Scaffold(
      /// Custom Appbar
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Changer Nom',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Headings
            Text(
              'Utilisez votre vrai nom pour une vérification facile. Ce nom apparaîtra sur plusieurs pages.',
              style: Theme.of(context).textTheme.labelMedium,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Text field and Button
            Form(
                key: controller.updateUserNameFormKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: controller.firstName,
                      validator: (value) =>
                          TValidator.validateEmptyText('Prenom', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TTexts.firstName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                    const SizedBox(height: TSizes.spaceBtwInputFields),
                    TextFormField(
                      controller: controller.lastName,
                      validator: (value) =>
                          TValidator.validateEmptyText('Nom', value),
                      expands: false,
                      decoration: const InputDecoration(
                          labelText: TTexts.lastName,
                          prefixIcon: Icon(Iconsax.user)),
                    ),
                  ],
                )),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () => controller.updateUserName(),
                  child: const Text('Sauvgarder')),
            ),
          ],
        ),
      ),
    );
  }
}
