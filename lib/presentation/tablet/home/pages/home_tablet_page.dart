import 'dart:async';
import 'dart:developer';

import 'package:cashiru/core/components/search_input.dart';
import 'package:cashiru/presentation/home/pages/dashboard_page.dart';
import 'package:cashiru/presentation/order/bloc/order/order_bloc.dart' as order_bloc;
import 'package:cashiru/presentation/tablet/home/pages/dashboard_tablet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashiru/core/assets/assets.gen.dart';
import 'package:cashiru/core/components/buttons.dart';
import 'package:cashiru/core/components/menu_button.dart';
import 'package:cashiru/core/components/spaces.dart';
import 'package:cashiru/core/constants/colors.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/core/extensions/int_extension.dart';
import 'package:cashiru/data/models/response/category_response_model.dart';
import 'package:cashiru/data/models/response/product_response_model.dart';
import 'package:cashiru/presentation/home/bloc/category/category_bloc.dart';
import 'package:cashiru/presentation/home/bloc/checkout/checkout_bloc.dart' as checkout_bloc;
import 'package:cashiru/presentation/home/widgets/product_card.dart';
import 'package:cashiru/presentation/order/widgets/payment_cash_dialog.dart';
import 'package:cashiru/presentation/tablet/home/widgets/home_title.dart';
import 'package:cashiru/presentation/home/bloc/product/product_bloc.dart' as product_bloc;
import '../widgets/order_menu.dart';

class HomeTabletPage extends StatefulWidget {
  const HomeTabletPage({super.key});

  @override
  State<HomeTabletPage> createState() => _HomeTabletPageState();
}

class _HomeTabletPageState extends State<HomeTabletPage> {
  final searchController = TextEditingController();
  final tableNumberController = TextEditingController();
  final orderNameController = TextEditingController();
  final indexValuePayment = ValueNotifier(0);
  bool isOpenBill = false;
  int indexValue = 0;
  int finaltotal = 0;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    context.read<CategoryBloc>().add(const CategoryEvent.fetchCategories());
    context.read<product_bloc.ProductBloc>().add(const product_bloc.ProductEvent.fetchProducts());
  }

  void onCategoryTap(int index) {
    searchController.clear();
    indexValue = index;

    // context.read<ProductBloc>().add(ProductEvent.fetchByCategory(categoryId));
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
    tableNumberController.dispose();
    orderNameController.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'confirmation_screen',
      child: Scaffold(
        body: Row(
          children: [
            Expanded(
              flex: 3,
              child: Align(
                alignment: AlignmentDirectional.topStart,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HomeTitle(
                          controller: searchController,
                          onChanged: (value) {
                            if (_debounce?.isActive ?? false) _debounce!.cancel();
                            _debounce = Timer(const Duration(milliseconds: 300), () {
                              context.read<product_bloc.ProductBloc>().add(
                                product_bloc.ProductEvent.searchProducts(value),
                              );
                            });
                          },
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: context.deviceWidth,
                          height: 84,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SizedBox(
                                  width: 120,
                                  height: 84,
                                  child: MenuButton(
                                    size: 30,
                                    iconPath: Assets.icons.allCategories.path,
                                    label: 'All',
                                    isImage: false,
                                    isActive: indexValue == 0,
                                    onPressed: () {
                                      onCategoryTap(0);
                                      context.read<product_bloc.ProductBloc>().add(
                                        const product_bloc.ProductEvent.fetchProducts(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              BlocBuilder<CategoryBloc, CategoryState>(
                                builder: (context, state) {
                                  switch (state) {
                                    case Loading():
                                      return const Center(child: CircularProgressIndicator());
                                    case Failure(message: String message):
                                      return Center(child: Text(message));
                                    case Success(categories: List<Category> categories):
                                      final cat = categories.map((e) {
                                        int index = categories.indexOf(e) + 1;
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: SizedBox(
                                            width: 120,
                                            height: 84,
                                            child: MenuButton(
                                              iconPath: Assets.icons.allCategories.path,
                                              label:
                                                  categories[index - 1].name ?? 'Category $index',
                                              isActive: indexValue == index,
                                              isImage: false,
                                              onPressed: () {
                                                context.read<product_bloc.ProductBloc>().add(
                                                  product_bloc.ProductEvent.fetchProductsByCategory(
                                                    e.id!,
                                                  ),
                                                );
                                                onCategoryTap(index);
                                              },
                                              size: 30,
                                            ),
                                          ),
                                        );
                                      }).toList();
                                      return Row(children: cat);

                                    case _:
                                      return const Text('no data');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        const SpaceHeight(35.0),
                        BlocBuilder<product_bloc.ProductBloc, product_bloc.ProductState>(
                          builder: (context, state) {
                            switch (state) {
                              case product_bloc.Loading():
                                return const Center(child: CircularProgressIndicator());
                              case product_bloc.Failure(message: String message):
                                return Center(child: Text(message));
                              case product_bloc.Success(products: List productData):
                                if (productData.isEmpty) {
                                  return const Center(child: Text('No products available'));
                                } else {
                                  return GridView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: productData.length,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 0.8,
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 16.0,
                                      mainAxisSpacing: 16.0,
                                    ),
                                    itemBuilder: (context, index) =>
                                        ProductCard(data: productData[index]),
                                  );
                                }

                              default:
                                return const SizedBox.shrink();
                            }
                          },
                        ),

                        const SpaceHeight(30.0),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Right
            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text(
                                'Orders #',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(16.0),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Item',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 130),
                              SizedBox(
                                width: 50.0,
                                child: Text(
                                  'Qty',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Text(
                                  'Price',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SpaceHeight(8),
                          const Divider(),
                          const SpaceHeight(8),
                          SizedBox(
                            width: context.deviceWidth,
                            height: context.deviceHeight * 0.45,
                            child:
                                BlocBuilder<
                                  checkout_bloc.CheckoutBloc,
                                  checkout_bloc.CheckoutState
                                >(
                                  builder: (context, state) {
                                    switch (state) {
                                      case checkout_bloc.Success(
                                        products: List products,
                                        total: int _,
                                        qty: int qty,
                                      ):
                                        return qty == 0
                                            ? Center(
                                                child: Text(
                                                  'No items in the cart',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black54,
                                                  ),
                                                ),
                                              )
                                            : ListView.separated(
                                                shrinkWrap: true,
                                                physics: const ClampingScrollPhysics(),
                                                itemBuilder: (context, index) =>
                                                    OrderMenu(data: products[index]),
                                                separatorBuilder: (context, index) =>
                                                    const SpaceHeight(1.0),
                                                itemCount: products.length,
                                              );

                                      case _:
                                        return SizedBox.shrink();
                                    }
                                  },
                                ),
                          ),
                          const SpaceHeight(8.0),
                          const Divider(),
                          const SpaceHeight(8.0),

                          if (!isOpenBill) ...[
                            ValueListenableBuilder(
                              valueListenable: indexValuePayment,
                              builder: (context, value, _) => Row(
                                children: [
                                  Flexible(
                                    child: MenuButton(
                                      iconPath: Assets.icons.cash.path,
                                      label: 'CASH',
                                      isActive: value == 1,
                                      onPressed: () {
                                        indexValuePayment.value = 1;

                                        final theState = context
                                            .read<checkout_bloc.CheckoutBloc>()
                                            .state;
                                        if (theState is checkout_bloc.Success) {
                                          context.read<order_bloc.OrderBloc>().add(
                                            order_bloc.OrderEvent.addPaymentMethod(
                                              'CASH',
                                              theState.products,
                                              theState.qty,
                                              theState.total,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  const SpaceWidth(16.0),
                                  Flexible(
                                    child: MenuButton(
                                      iconPath: Assets.icons.qrCode.path,
                                      label: 'QR',
                                      isActive: value == 2,
                                      // size: 2,
                                      onPressed: () {
                                        indexValuePayment.value = 2;
                                        log("Payment QRIS");

                                        final theState = context
                                            .read<checkout_bloc.CheckoutBloc>()
                                            .state;
                                        if (theState is checkout_bloc.Success) {
                                          context.read<order_bloc.OrderBloc>().add(
                                            order_bloc.OrderEvent.addPaymentMethod(
                                              'QR',
                                              theState.products,
                                              theState.qty,
                                              theState.total,
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
                                        indexValuePayment.value = 3;
                                        log("Payment TRANSFER");

                                        final theState = context
                                            .read<checkout_bloc.CheckoutBloc>()
                                            .state;
                                        if (theState is checkout_bloc.Success) {
                                          context.read<order_bloc.OrderBloc>().add(
                                            order_bloc.OrderEvent.addPaymentMethod(
                                              'TRANSFER',
                                              theState.products,
                                              theState.qty,
                                              theState.total,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SpaceHeight(8.0),
                          const Divider(),
                          const SpaceHeight(8.0),
                          BlocBuilder<checkout_bloc.CheckoutBloc, checkout_bloc.CheckoutState>(
                            builder: (context, state) {
                              int finalTotalPrice = state is checkout_bloc.Success
                                  ? state.total
                                  : 0;
                              return Column(
                                children: [
                                  const SpaceHeight(12.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Total',
                                        style: TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        finalTotalPrice.currencyFormatRp,
                                        style: const TextStyle(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          const SpaceHeight(100.0),
                        ],
                      ),
                    ),
                    BlocBuilder<checkout_bloc.CheckoutBloc, checkout_bloc.CheckoutState>(
                      builder: (context, state) {
                        int finalTotalPrice = state is checkout_bloc.Success ? state.total : 0;
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: isOpenBill
                              ? Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Button.filled(
                                    onPressed: () async {
                                      //open bill success snack bar
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Save Draft Order Success'),
                                          backgroundColor: AppColors.primary,
                                        ),
                                      );

                                      context.pushReplacement(const DashboardTabletPage());
                                    },
                                    label: 'Save & Print',
                                    fontSize: 14,
                                    height: 52,
                                    width: context.deviceWidth,
                                  ),
                                )
                              : ColoredBox(
                                  color: AppColors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24.0,
                                      vertical: 16.0,
                                    ),
                                    child: Button.filled(
                                      onPressed: () {
                                        if (indexValuePayment.value == 0) {
                                        } else if (indexValuePayment.value == 1) {
                                          showDialog(
                                            context: context,
                                            builder: (context) => PaymentCashDialog(
                                              price: finalTotalPrice,
                                              isTablet: true,
                                            ),
                                          );
                                        } else if (indexValuePayment.value == 2) {
                                          // Todo : Implement Another Type Dialog
                                          // showDialog(
                                          //   context: context,
                                          //   barrierDismissible: false,
                                          //   builder: (context) => PaymentQrisDialog(
                                          //     price: finalTotalPrice,
                                          //     isTablet: true,
                                          //   ),
                                          // );
                                        }
                                      },
                                      label: 'Payment',
                                    ),
                                  ),
                                ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
