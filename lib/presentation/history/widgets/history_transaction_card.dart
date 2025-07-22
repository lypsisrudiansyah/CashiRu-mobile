import 'package:cashiru/data/models/response/history_response_model.dart';
import 'package:flutter/material.dart';
import 'package:cashiru/core/components/buttons.dart';
import 'package:cashiru/core/extensions/date_time_extension.dart';
import 'package:cashiru/core/extensions/int_extension.dart';
import 'package:cashiru/core/extensions/string_extension.dart';

import '../../../../core/assets/assets.gen.dart';
import '../../../../core/constants/colors.dart';

class HistoryTransactionCard extends StatelessWidget {
  final History data;
  final EdgeInsetsGeometry? padding;

  const HistoryTransactionCard({super.key, required this.data, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: padding,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 48.0,
            blurStyle: BlurStyle.outer,
            spreadRadius: 0,
            color: AppColors.black.withOpacity(0.06),
          ),
        ],
      ),
      child: ExpansionTile(
        shape: RoundedRectangleBorder(
          side: BorderSide.none,
          borderRadius: BorderRadius.circular(0.0),
        ),
        title: Wrap(
  spacing: 12.0, // jarak horizontal antar item
  runSpacing: 8.0, // jarak vertikal antar baris
  crossAxisAlignment: WrapCrossAlignment.center,
  children: [
    Assets.icons.payments.svg(),
    Text(
      '${data.createdAt!.toFormattedTime()} - ${data.paymentMethod! == 'QR' ? 'QRIS' : data.paymentMethod! == 'TRANSFER' ? 'TRANSFER' : 'Cash'}',
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
    ),
    Text(
      double.parse(data.total!).toInt().currencyFormatRp,
      style: const TextStyle(
        color: AppColors.green,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
    ),
  ],
),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: data.orderItems!.length + 1,
            itemBuilder: (context, index) {
              if (index == data.orderItems!.length) {
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    left: 16,
                    right: 16,
                    bottom: 16,
                  ),
                  child: Button.filled(
                    onPressed: () async {
                      // print receipt
                      // final printInt = await CwbPrint.instance.printOrderV2(
                      //   data.orders,
                      //   data.totalQuantity,
                      //   data.total,
                      //   data.paymentMethod,
                      //   data.nominalBayar,
                      //   data.namaKasir,
                      //   'Customer',
                      // );
                      // CwbPrint.instance.printReceipt(printInt);
                    },
                    label: 'Print Receipt',
                  ),
                );
              }
              final item = data.orderItems![index];
              return ListTile(
                title: Text(item.product!.name ?? 'Product ${index + 1}'),
                subtitle: Text(
                  '${item.quantity} x ${item.product!.price?.currencyFormatRp}',
                ),
                trailing: Text(
                  '${item.quantity! * item.product!.price!.toIntegerFromText}'
                      .currencyFormatRp,
                  style: const TextStyle(
                    color: AppColors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              );
              //button print
            },
          ),
        ],
      ),
    );
  }
}
