import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaisi_app/Screens/AuthentificationF/controllers/signup_controller.dart';
import 'package:kaisi_app/Screens/SideBar/profile/profile_menu.dart';
import 'package:kaisi_app/Widgets/custom_shapes/images/t_circular_image.dart';
import 'package:kaisi_app/Widgets/custom_shapes/shimmers/shimmer.dart';
import 'package:kaisi_app/Widgets/custom_shapes/texts/section_heading.dart';
// import 'package:kaisi_app/utilities/constants/routes.dart';
import 'package:kaisi_app/utilities/constants/sizes.dart';
import '../../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  final SignupController signupController = Get.find<SignupController>();
  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : "assets/images/user.png";
                        return controller.imageUploading.value
                            ? const TShimmerEffect(
                                width: 80, height: 80, radius: 80)
                            : TCircularImage(
                                image: image,
                                width: 80,
                                height: 80,
                                isNetworkImage: networkImage.isNotEmpty);
                      },
                    ),
                    TextButton(
                      onPressed: controller.imageUploading.value
                          ? () {}
                          : () => controller.uploadUserProfilePicture(),
                      child: const Text('Changer la photo de profil'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Informations de profil', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              // TProfileMenu(
              //     onPressed: () =>
              //         Navigator.pushNamed(context, changeNameRoute),
              //     title: 'Nom',
              //     value: signupController.lastName.value),
              // TProfileMenu(
              //     onPressed: () => {
              //           Navigator.pushNamed(context, changeNameRoute),
              //         },
              //     title: 'Prénom',
              //     value: signupController.firstName.value),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Informations de profil', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              // TProfileMenu(
              //     onPressed: () {},
              //     title: 'Adresse E-mail',
              //     value: signupController.email.value),
              // TProfileMenu(
              //     onPressed: () {},
              //     title: 'Numéro de téléphone',
              //     value: signupController.phoneNumber.value),
              TProfileMenu(onPressed: () {}, title: 'Genre', value: 'Homme'),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text('Fermer le compte',
                        style: TextStyle(color: Colors.red))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
