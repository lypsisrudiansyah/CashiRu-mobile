import 'dart:async';

import 'package:cashiru/core/constants/colors.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/data/models/response/category_response_model.dart';
import 'package:cashiru/presentation/auth/pages/login_page.dart';
import 'package:cashiru/presentation/home/bloc/category/category_bloc.dart';
import 'package:cashiru/presentation/home/bloc/product/product_bloc.dart' as product_bloc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/search_input.dart';
import '../../../core/components/spaces.dart';

import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  final indexValue = ValueNotifier(0);
  int currentIndex = 0;
  Timer? _debounce;

  @override
  void initState() {
    // AuthLocalDatasource().clearAuthData();
    // context.pushReplacement(const LoginPage());
    context.read<CategoryBloc>().add(const CategoryEvent.fetchCategories());
    context.read<product_bloc.ProductBloc>().add(const product_bloc.ProductEvent.fetchProducts());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void onCategoryTap(int index) {
    searchController.clear();
    currentIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: const Text('Menu Kami', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),

        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SearchInput(
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
          const SpaceHeight(16.0),
          SizedBox(
            height: 90,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  height: 80,
                  width: 95,
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: MenuButton(
                    iconPath: Assets.icons.allCategories.path,
                    label: 'All',
                    isActive: currentIndex == 0,
                    onPressed: () {
                      onCategoryTap(0);
                      context.read<product_bloc.ProductBloc>().add(
                        const product_bloc.ProductEvent.fetchProducts(),
                      );
                    },
                  ),
                ),
                const SpaceWidth(0.0),
                BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    switch (state) {
                      case Loading():
                        return const Center(child: CircularProgressIndicator());
                      case Failure(message: String message):
                        return Center(child: Text(message));
                      case Success(categories: List<Category> categories):
                        return Row(
                          children: categories.map((e) {
                            int index = categories.indexOf(e) + 1;
                            return SizedBox(
                              height: 80,
                              width: 90,
                              child: MenuButton(
                                iconPath: Assets.icons.allCategories.path,
                                label: e.name ?? 'Category $index',
                                isActive: currentIndex == index,
                                onPressed: () {
                                  context.read<product_bloc.ProductBloc>().add(
                                    product_bloc.ProductEvent.fetchProductsByCategory(e.id!),
                                  );
                                  onCategoryTap(index);
                                },
                              ),
                            );
                          }).toList(),
                        );
                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
          const SpaceHeight(16.0),
          BlocBuilder<product_bloc.ProductBloc, product_bloc.ProductState>(
            builder: (context, state) {
              switch (state) {
                //* Using product_bloc alias that needed because of conflict with category_bloc states, you can try to Hide Failure state class it will be no error on linter
                case product_bloc.Loading():
                  return const Center(child: CircularProgressIndicator());
                case product_bloc.Failure(message: String message):
                  return Center(child: Text(message));
                case product_bloc.Success(products: List dummyProducts):
                  if (dummyProducts.isEmpty) {
                    return const Center(child: Text('No products available'));
                  } else {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: dummyProducts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 0.75,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemBuilder: (context, index) => ProductCard(data: dummyProducts[index]),
                    );
                  }

                default:
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Assets.icons.orders.svg(width: 114.0),
                        const SpaceHeight(4.0),
                        const Text(
                          'Belum ada Produk',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: AppColors.grey),
                        ),
                      ],
                    ),
                  );
                // return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
