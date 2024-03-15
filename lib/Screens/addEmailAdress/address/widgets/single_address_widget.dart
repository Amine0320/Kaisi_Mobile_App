// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:kaisi_app/Controllers/address_controller.dart';
// import 'package:kaisi_app/Models/address_model.dart';
// import 'package:kaisi_app/Screens/helpers/helper_functions.dart';
// import 'package:kaisi_app/Widgets/custom_shapes/containers/rounded_container.dart';
// import 'package:kaisi_app/utilities/constants/colors.dart';
// import 'package:kaisi_app/utilities/constants/sizes.dart';

// class TSingleAddress extends StatelessWidget {
//   const TSingleAddress({
//     super.key,
//     required this.address,
//     required this.onTap,
//   });

//   final AddressModel address;
//   final VoidCallback onTap;

//   @override
//   Widget build(BuildContext context) {
//     final controller = AddressController.instance;
//     final dark = THelperFunctions.isDarkMode(context);
//     return Obx(
//       () {
//         final selectedAddressId = controller.selectedAddress.value.id;
//         final isAddressSelected = selectedAddressId == address.id;
//         return GestureDetector(
//           onTap: onTap,
//           child: TRoundedContainer(
//             showBorder: true,
//             padding: const EdgeInsets.all(TSizes.md),
//             width: double.infinity,
//             backgroundColor: isAddressSelected
//                 ? TColors.primary.withOpacity(0.5)
//                 : Colors.transparent,
//             borderColor: isAddressSelected
//                 ? Colors.transparent
//                 : dark
//                     ? TColors.darkerGrey
//                     : TColors.grey,
//             margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
//             child: Stack(
//               children: [
//                 Positioned(
//                   right: 5,
//                   top: 0,
//                   child: Icon(
//                     isAddressSelected
//                         ? Iconsax.tick_circle1
//                         : Iconsax.tick_circle1,
//                     color: isAddressSelected
//                         ? TColors.primary
//                         : dark
//                             ? TColors.darkerGrey
//                             : TColors.grey,
//                   ),
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       address.name,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: Theme.of(context).textTheme.titleLarge,
//                     ),
//                     const SizedBox(height: TSizes.sm / 2),
//                     Text(address.formattedPhoneNo,
//                         maxLines: 1, overflow: TextOverflow.ellipsis),
//                     const SizedBox(height: TSizes.sm / 2),
//                     Text(address.toString(), softWrap: true),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
