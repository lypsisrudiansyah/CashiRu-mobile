import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashiru/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:flutter/material.dart';
import 'package:cashiru/core/components/spaces.dart';
import 'package:cashiru/core/constants/variables.dart';
import 'package:cashiru/core/extensions/int_extension.dart';
import 'package:cashiru/presentation/home/models/order_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/colors.dart';

// * Try This
class OrderMenu extends StatelessWidget {
  final OrderItem data;
  const OrderMenu({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    // final qtyController = TextEditingController(text: '3');

    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                  child: CachedNetworkImage(
                    width: 40,
                    height: 40,
                    fit: BoxFit.fill,
                    imageUrl: '${Variables.imageBaseUrl}${data.product.image}',
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.food_bank_outlined, size: 40),
                  ),
                ),
                title: Text(
                  data.product.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(data.product.price!),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    context.read<CheckoutBloc>().add(CheckoutEvent.removeCheckout(data.product));
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: AppColors.white,
                    child: const Icon(Icons.remove_circle, color: AppColors.primary),
                  ),
                ),
                SizedBox(width: 30.0, child: Center(child: Text(data.quantity.toString()))),
                GestureDetector(
                  onTap: () {
                    context.read<CheckoutBloc>().add(CheckoutEvent.addCheckout(data.product));
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    color: AppColors.white,
                    child: const Icon(Icons.add_circle, color: AppColors.primary),
                  ),
                ),
              ],
            ),
            const SpaceWidth(8),
            SizedBox(
              width: 80.0,
              child: Text(
                (double.parse(data.product.price!).toInt() * data.quantity).currencyFormatRp,
                textAlign: TextAlign.right,
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SpaceHeight(16),
        // Row(
        //   children: [
        //     Flexible(
        //       child: TextFormField(
        //         controller: noteController,
        //         decoration: InputDecoration(
        //           border: OutlineInputBorder(
        //             borderRadius: BorderRadius.circular(8.0),
        //           ),
        //           hintText: 'Catatan pesanan',
        //         ),
        //       ),
        //     ),
        //     const SpaceWidth(12),
        //     GestureDetector(
        //       onTap: () {},
        //       child: Container(
        //         padding: const EdgeInsets.all(16.0),
        //         height: 60.0,
        //         width: 60.0,
        //         decoration: const BoxDecoration(
        //           color: AppColors.primary,
        //           borderRadius: BorderRadius.all(Radius.circular(8.0)),
        //         ),
        //         child: Assets.icons.delete.svg(
        //           colorFilter:
        //               const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
