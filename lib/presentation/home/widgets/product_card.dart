import 'package:cached_network_image/cached_network_image.dart';
import 'package:cashiru/core/constants/variables.dart';
import 'package:cashiru/core/extensions/int_extension.dart';
import 'package:cashiru/data/models/response/product_response_model.dart';
import 'package:cashiru/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:cashiru/presentation/home/models/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class ProductCard extends StatelessWidget {
  final Product data;

  const ProductCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            context.read<CheckoutBloc>().add(CheckoutEvent.addCheckout(data));
          },
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                // * Try This
                side: const BorderSide(width: 1, color: AppColors.card),
                borderRadius: BorderRadius.circular(20),
              ),
              color: AppColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),

                // * Try This
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.disabled.withOpacity(0.4),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(50.0)),
                    child: CachedNetworkImage(
                      height: 50,
                      fit: BoxFit.fitWidth,
                      imageUrl: '${Variables.imageBaseUrl}${data.image}',
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(
                        Icons.food_bank_outlined,
                        size: 50,
                        color: AppColors.primary.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  data.name ?? '',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SpaceHeight(2.0),
                Text(
                  data.category?.name ?? '',
                  style: const TextStyle(color: AppColors.grey, fontSize: 12),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        double.parse(data.price!).toInt().currencyFormatRpV2,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      // * Try This
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        color: AppColors.primary,
                      ),
                      child: const Icon(Icons.add, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            switch (state) {
              // case Failure(message: String message):
              //   return Center(child: Text(message));
              case Success(products: List<OrderItem> products, total: int _, qty: int _):
                if (products.any((element) => element.product.id == data.id)) {
                  var index = products.indexWhere((element) => element.product.id == data.id);
                  // * Try This

                  return Positioned(
                    top: 18,
                    right: 18,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: AppColors.primary,
                      child: Text(
                        products[index].quantity.toString(),
                        style: const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ),
                  );
                }
                // * Try This
                return const SizedBox.shrink();
              case _:
                // * Try This
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
