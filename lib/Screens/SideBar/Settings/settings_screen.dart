import 'package:kaisi_app/Screens/appbar/appbar.dart';
import 'package:kaisi_app/Widgets/custom_shapes/containers/primary_header_container.dart';
import 'package:kaisi_app/Widgets/custom_shapes/list_tiles/settings_menu_tile.dart';
import 'package:kaisi_app/Widgets/custom_shapes/list_tiles/user_profile_tile.dart';
import 'package:kaisi_app/Widgets/custom_shapes/texts/section_heading.dart';
import 'package:kaisi_app/utilities/constants/colors.dart';
import 'package:kaisi_app/utilities/constants/routes.dart';
import 'package:kaisi_app/utilities/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // Intercept the back button press and redirect to Home Screen
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// -- Header
              TPrimaryHeaderContainer(
                child: Column(
                  children: [
                    /// AppBar
                    TAppBar(
                        title: Text('Compte',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: TColors.white))),

                    /// User Profile Card
                    TUserProfileTile(onPressed: () {
                      Navigator.pushNamed(context, profileScreenRoute);
                    }),
                    const SizedBox(height: TSizes.spaceBtwSections),
                  ],
                ),
              ),

              /// -- Profile Body
              Padding(
                padding: const EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// -- Account  Settings
                    const TSectionHeading(
                        title: 'Parametres', showActionButton: false),
                    const SizedBox(height: TSizes.spaceBtwItems),
                    TSettingsMenuTile(
                        icon: Iconsax.safe_home,
                        title: 'Mon Profil',
                        subTitle: 'Modifier votre profil',
                        onTap: () {
                          Navigator.pushNamed(context, profileScreenRoute);
                        }),
                    TSettingsMenuTile(
                        icon: Iconsax.bag_tick,
                        title: 'Mes Factures',
                        subTitle: 'Voir vos factures',
                        onTap: () {}),
                    const TSettingsMenuTile(
                        icon: Iconsax.bank,
                        title: 'Coordonnees Bancaires',
                        subTitle: 'Voir vos corrdonnees bancaires'),
                    TSettingsMenuTile(
                        icon: Iconsax.notification,
                        title: 'Notifications',
                        subTitle: 'Activer/Desactiver les notifications',
                        onTap: () {}),
                    const TSettingsMenuTile(
                        icon: Iconsax.security_card,
                        title: 'Confidentialité du compte',
                        subTitle:
                            "Gérer l'utilisation des données et les comptes connectés"),

                    /// -- Logout Button
                    const SizedBox(height: TSizes.lspaceBtwSections),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, loginScreenRoute),
                            child: const Text('Se deconnecter'))),
                    const SizedBox(height: TSizes.spaceBtwSections * 2.5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
