import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:cashiru/presentation/home/models/order_item.dart';
import 'package:cashiru/presentation/home/pages/dashboard_page.dart';
import 'package:cashiru/presentation/order/bloc/order/order_bloc.dart' as order_bloc;
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/spaces.dart';
import '../widgets/order_card.dart';
import '../widgets/payment_cash_dialog.dart';
import '../widgets/process_button.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final indexValue = ValueNotifier(0);
  final TextEditingController orderNameController = TextEditingController();
  final TextEditingController tableNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _connectDefaultPrinter();
  }

  Future<void> _connectDefaultPrinter() async {
    final defaultPrinter = await AuthLocalDatasource().getDefaultPrinter();
    if (defaultPrinter != null) {
      bool isConnected = await PrintBluetoothThermal.connectionStatus;
      if (!isConnected) {
        final connected = await PrintBluetoothThermal.connect(
          macPrinterAddress: defaultPrinter.macAddress,
        );
        print("Printer default connected: $connected");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.push(const DashboardPage());
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: const Text(
          'Order Detail',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          switch (state) {
            case Success(products: List products, total: int _, qty: int qty):
              return qty == 0
                  ? Center(
                      child: Text(
                        'No items in the cart',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      itemCount: products.length,
                      separatorBuilder: (context, index) => const SpaceHeight(20.0),
                      itemBuilder: (context, index) => OrderCard(
                        padding: paddingHorizontal,
                        data: products[index],
                        onDeleteTap: () {
                          context.read<CheckoutBloc>().add(
                            CheckoutEvent.removeCheckout(products[index]),
                          );
                        },
                      ),
                    );
            case _:
              return SizedBox.shrink();
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ValueListenableBuilder(
              valueListenable: indexValue,
              builder: (context, value, _) => Row(
                children: [
                  Flexible(
                    child: MenuButton(
                      iconPath: Assets.icons.cash.path,
                      label: 'CASH',
                      isActive: value == 1,
                      onPressed: () {
                        indexValue.value = 1;

                        final state = context.read<CheckoutBloc>().state;
                        if (state is Success) {
                          context.read<order_bloc.OrderBloc>().add(
                            order_bloc.OrderEvent.addPaymentMethod(
                              'CASH',
                              state.products,
                              state.qty,
                              state.total,
                            ),
                          );
                        }
                      },
                      // onPressed: () {
                      //   indexValue.value = 1;
                      //   List<OrderItem> products = context.read<CheckoutBloc>().state is Success
                      //       ? (context.read<CheckoutBloc>().state as Success).products
                      //       : [];
                      //   int qty = context.read<CheckoutBloc>().state is Success
                      //       ? (context.read<CheckoutBloc>().state as Success).qty
                      //       : 0;
                      //   int total = context.read<CheckoutBloc>().state is Success
                      //       ? (context.read<CheckoutBloc>().state as Success).total
                      //       : 0;
                      //   context.read<order_bloc.OrderBloc>().add(
                      //     order_bloc.OrderEvent.addPaymentMethod('CASH', products, qty, total),
                      //   );
                      // },
                    ),
                  ),
                  const SpaceWidth(16.0),
                  Flexible(
                    child: MenuButton(
                      iconPath: Assets.icons.qrCode.path,
                      label: 'QR',
                      isActive: value == 2,
                      onPressed: () {
                        indexValue.value = 2;
                        final state = context.read<CheckoutBloc>().state;
                        if (state is Success) {
                          context.read<order_bloc.OrderBloc>().add(
                            order_bloc.OrderEvent.addPaymentMethod(
                              'QR',
                              state.products,
                              state.qty,
                              state.total,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SpaceWidth(16.0),
                  Flexible(
                    child: MenuButton(
                      iconPath: Assets.icons.debit.path,
                      label: 'TRANSFER',
                      isActive: value == 3,
                      onPressed: () {
                        indexValue.value = 3;
                        final state = context.read<CheckoutBloc>().state;
                        if (state is Success) {
                          context.read<order_bloc.OrderBloc>().add(
                            order_bloc.OrderEvent.addPaymentMethod(
                              'TRANSFER',
                              state.products,
                              state.qty,
                              state.total,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(20.0),
            BlocBuilder<CheckoutBloc, CheckoutState>(
              builder: (context, state) {
                int total = state is Success ? state.total : 0;
                return ProcessButton(
                  price: total,
                  onPressed: () async {
                    if (total == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'No items in the cart',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    showDialog(
                      context: context,
                      builder: (context) => PaymentCashDialog(price: total),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
