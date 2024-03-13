import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:kaisi_app/Screens/SideBar/profile/profile_menu.dart';
import 'package:kaisi_app/Screens/appbar/appbar.dart';
import 'package:kaisi_app/Widgets/custom_shapes/images/t_circular_image.dart';
import 'package:kaisi_app/Widgets/custom_shapes/shimmers/shimmer.dart';
import 'package:kaisi_app/Widgets/custom_shapes/texts/section_heading.dart';
import 'package:kaisi_app/contants/routes.dart';
import 'package:kaisi_app/utilities/constants/image_strings.dart';
import 'package:kaisi_app/utilities/constants/sizes.dart';
import '../../../controllers/user_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
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
                            : TImages.user;
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
                  title: 'Informations de profile', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      changeNameRoute,
                      (route) => false,
                    );
                  },
                  title: 'Nom',
                  value: controller.user.value.fullName),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Prenom',
                  value: controller.user.value.username),
              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              const TSectionHeading(
                  title: 'Informations Personnels', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Identifiant',
                  value: '45689',
                  icon: Iconsax.copy),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Adresse E-mail',
                  value: controller.user.value.email),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Numero de tel',
                  value: controller.user.value.phoneNumber),
              TProfileMenu(onPressed: () {}, title: 'Gender', value: 'Male'),
              TProfileMenu(
                  onPressed: () {},
                  title: 'Date de naissance',
                  value: '1 Jan, 1900'),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),
              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text('Supprimer le compte ',
                        style: TextStyle(color: Colors.red))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
