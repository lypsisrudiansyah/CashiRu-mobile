import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/core/extensions/int_extension.dart';
import 'package:cashiru/core/extensions/string_extension.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/data/models/request/order_request_model.dart';
import 'package:cashiru/presentation/order/bloc/order/order_bloc.dart';
import 'package:cashiru/presentation/order/widgets/payment_success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';

class PaymentCashDialog extends StatefulWidget {
  final bool isTablet;
  final int price;
  const PaymentCashDialog({
    super.key,
    required this.price,
    this.isTablet = false,
  });

  @override
  State<PaymentCashDialog> createState() => _PaymentCashDialogState();
}

class _PaymentCashDialogState extends State<PaymentCashDialog> {
  TextEditingController?
  priceController; // = TextEditingController(text: widget.price.currencyFormatRp);

  @override
  void initState() {
    priceController = TextEditingController(
      text: widget.price.currencyFormatRp,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Stack(
        children: [
          IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.highlight_off),
            color: AppColors.primary,
          ),
          Center(
            
            child: Padding(
              padding: EdgeInsets.only(top: 12.0),
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  String paymentMethod = state is Success
                      ? state.paymentMethod
                      : 'Cash';
                  return Text(
                    paymentMethod,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: context.deviceWidth * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceHeight(16.0),
            CustomTextField(
              controller: priceController!,
              label: '',
              showLabel: false,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final int priceValue = value.toIntegerFromText;
                priceController!.text = priceValue.currencyFormatRp;
                priceController!.selection = TextSelection.fromPosition(
                  TextPosition(offset: priceController!.text.length),
                );
              },
            ),

            const SpaceHeight(30.0),
            BlocBuilder<OrderBloc, OrderState>(
              builder: (context, state) {
                return Button.filled(
                  onPressed: () async {
                    //check if price is empty
                    if (priceController!.text.isEmpty) {
                      //show dialog error
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please input the price'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    //if price less than total price
                    if (priceController!.text.toIntegerFromText <
                        widget.price) {
                      //show dialog error
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                              'The nominal is less than the total price',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return;
                    }
                    final authData = await AuthLocalDatasource().getAuthData();
                    String paymentMethod = state is Success
                        ? state.paymentMethod
                        : 'Cash';
                    int cashierId = authData!.user!.id!;
                    OrderRequestModel orderRequest = OrderRequestModel(
                      cashierId: cashierId,
                      paymentMethod: paymentMethod,
                      items: state is Success
                          ? state.orders.map((order) {
                              return Item(
                                productId: order.product.id,
                                quantity: order.quantity,
                              );
                            }).toList()
                          : [],
                    );
                    context.read<OrderBloc>().add(
                      OrderEvent.addOrder(orderRequest),
                    );
                    showDialog(
                      context: context,
                      builder: (context) =>
                          PaymentSuccessDialog(isTablet: widget.isTablet),
                    );
                  },
                  label: 'Pay',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
