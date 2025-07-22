// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_pos_app/core/components/buttons.dart';
// import 'package:flutter_pos_app/core/components/spaces.dart';
// import 'package:flutter_pos_app/core/extensions/build_context_ext.dart';
// import 'package:flutter_pos_app/core/extensions/int_ext.dart';
// import 'package:flutter_pos_app/core/extensions/string_ext.dart';
// import 'package:flutter_pos_app/presentation/home/bloc/checkout/checkout_bloc.dart';


// class DiscountDialog extends StatefulWidget {
//   const DiscountDialog({super.key});

//   @override
//   State<DiscountDialog> createState() => _DiscountDialogState();
// }

// class _DiscountDialogState extends State<DiscountDialog> {
//   @override
//   void initState() {
//     context
//         .read<DiscountsBloc>()
//         .add(const DiscountsEvent.fetchDiscountByStatus('active'));
//     super.initState();
//   }

//   int discountIdSelected = 0;

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Stack(
//         alignment: Alignment.center,
//         children: [
//           const Text(
//             'DISKON',
//             style: TextStyle(
//               color: AppColors.primary,
//               fontSize: 28,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: IconButton(
//               onPressed: () {
//                 context.pop();
//               },
//               icon: const Icon(
//                 Icons.cancel,
//                 color: AppColors.primary,
//                 size: 30.0,
//               ),
//             ),
//           ),
//         ],
//       ),
//       content: SingleChildScrollView(
//         child: Column(
//           children: [
//             BlocBuilder<DiscountsBloc, DiscountsState>(
//               builder: (context, state) {
//                 return state.maybeWhen(
//                   orElse: () => const SizedBox.shrink(),
//                   loading: () => const Center(
//                     child: CircularProgressIndicator(),
//                   ),
//                   success: (discounts) {
//                     return Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisSize: MainAxisSize.min,
//                       children: discounts.map((discount) {
//                         final String discountPrice =
//                             discount.type == 'percentage'
//                                 ? '${discount.value.replaceAll('.00', '')}%'
//                                 : discount.value
//                                     .replaceAll('.00', '')
//                                     .toIntegerFromText
//                                     .currencyFormatRp;
//                         return ListTile(
//                           title: Text('Nama Diskon: ${discount.name}'),
//                           subtitle: Text('Potongan harga  $discountPrice'),
//                           contentPadding: EdgeInsets.zero,
//                           textColor: AppColors.primary,
//                           trailing: Checkbox(
//                             value: discount.id == discountIdSelected,
//                             onChanged: (value) {
//                               setState(() {
//                                 discountIdSelected = discount.id;
//                                 context.read<CheckoutBloc>().add(
//                                       CheckoutEvent.addDiscount(
//                                         discount,
//                                       ),
//                                     );
//                               });
//                             },
//                           ),
//                           onTap: () {
//                             // context.pop();
//                           },
//                         );
//                       }).toList(),
//                     );
//                   },
//                 );
//               },
//             ),
//             const SpaceHeight(20),
//             Button.outlined(
//                 onPressed: () {
//                   context.read<CheckoutBloc>().add(
//                         const CheckoutEvent.removeDiscount(),
//                       );
//                 },
//                 label: "Reset Discount"),
//           ],
//         ),
//       ),
//     );
//   }
// }
