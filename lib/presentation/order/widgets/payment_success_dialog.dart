import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/core/extensions/date_time_extension.dart';
import 'package:cashiru/core/extensions/int_extension.dart';
import 'package:cashiru/data/dataoutput/printer_service.dart';
import 'package:cashiru/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:cashiru/presentation/home/models/order_item.dart';
import 'package:cashiru/presentation/home/pages/dashboard_page.dart';
import 'package:cashiru/presentation/order/bloc/order/order_bloc.dart' as order_bloc;
import 'package:cashiru/presentation/order/widgets/label_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';

class PaymentSuccessDialog extends StatelessWidget {
  final bool isTablet;
  const PaymentSuccessDialog({super.key, this.isTablet = false});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(child: Assets.icons.done.svg()),
          const SpaceHeight(24.0),
          const Text(
            'Payment has been successfully',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
      content: BlocBuilder<order_bloc.OrderBloc, order_bloc.OrderState>(
        builder: (context, state) {
          switch (state) {
            case order_bloc.Success(
              paymentMethod: String paymentMethod,
              nominalBayar: int nominalBayar,
              orders: List<OrderItem> orders,
              totalQuantity: int totalQuantity,
              total: int total,
            ):
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LabelValue(label: 'Payment Method', value: paymentMethod),
                  const Divider(height: 16.0),
                  LabelValue(
                    label: 'Total Quantity',
                    value: totalQuantity.toString(),
                  ),
                  const Divider(height: 16.0),
                  LabelValue(
                    label: 'Total Bill',
                    value: total.currencyFormatRp,
                  ),
                  // const Divider(height: 16.0),
                  // LabelValue(label: 'Cashier Name', value: 'John Doe'),
                  const Divider(height: 16.0),
                  LabelValue(
                    label: 'Transaction Date',
                    value: DateTime.now().toFormattedTime(),
                  ),
                  const SpaceHeight(20.0),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Button.filled(
                          onPressed: () {
                            isTablet
                                ? context.pushReplacement(
                                    // * Try This - ShouldBeTablet
                                    const DashboardPage(),
                                  )
                                : context.pushReplacement(
                                    const DashboardPage(),
                                  );
                            context.read<CheckoutBloc>().add(
                              CheckoutEvent.started(),
                            );

                            context.read<order_bloc.OrderBloc>().add(
                              order_bloc.OrderEvent.started(),
                            );
                          },
                          label: 'Done',
                          fontSize: 12,
                        ),
                      ),
                      const SpaceWidth(12.0),
                      Flexible(
                        child: Button.outlined(
                          onPressed: () async {
                            final printValue = await PrinterService.instance
                                .printOrder(
                                  paymentMethod,
                                  orders,
                                  totalQuantity,
                                  total,
                                );

                            await PrintBluetoothThermal.writeBytes(printValue);
                          },
                          label: 'Print',
                          icon: Assets.icons.print.svg(),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            case _:
              return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
