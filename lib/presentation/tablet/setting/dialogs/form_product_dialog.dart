import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:cashiru/core/components/custom_text_field.dart';
import 'package:cashiru/core/components/spaces.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/core/extensions/int_extension.dart';
import 'package:cashiru/core/extensions/string_extension.dart';
import 'package:cashiru/data/models/response/product_response_model.dart';
import 'package:cashiru/presentation/home/models/category_model.dart';

class FormProductDialog extends StatefulWidget {
  final Product? product;
  const FormProductDialog({super.key, this.product});

  @override
  State<FormProductDialog> createState() => _FormProductDialogState();
}

class _FormProductDialogState extends State<FormProductDialog> {
  TextEditingController? nameController;
  TextEditingController? priceController;
  TextEditingController? stockController;

  XFile? imageFile;

  bool isBestSeller = false;

  CategoryModel? selectCategory;
  String? imageUrl;

// * Try This Should Be Implemented
  List<CategoryModel> categories = [
    CategoryModel(name: 'Drink', value: 'drink'),
    CategoryModel(name: 'Food', value: 'food'),
    CategoryModel(name: 'Snack', value: 'snack'),
  ];

  @override
  void initState() {
    nameController = TextEditingController(text: widget.product?.name ?? '');
    priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
    stockController = TextEditingController(text: widget.product?.stock.toString() ?? '');
    isBestSeller = false;
    imageUrl = widget.product?.image;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    nameController!.dispose();
    priceController!.dispose();
    stockController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(onPressed: () => context.pop(), icon: const Icon(Icons.close)),
          Text(widget.product == null ? 'Add Product' : 'Edit Product'),
          const Spacer(),
        ],
      ),
      content: SingleChildScrollView(
        child: SizedBox(
          width: context.deviceWidth / 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(controller: nameController!, label: 'Product Name'),
              const SpaceHeight(20.0),
              CustomTextField(
                controller: priceController!,
                label: 'Price',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  final int priceValue = value.toIntegerFromText;
                  priceController!.text = priceValue.currencyFormatRp;
                  priceController!.selection = TextSelection.fromPosition(
                    TextPosition(offset: priceController!.text.length),
                  );
                },
              ),
              const SpaceHeight(20.0),
              // imageUrl == null
              //     ? ImagePickerWidget(
              //         label: 'Photo Product',
              //         onChanged: (file) {
              //           if (file == null) {
              //             return;
              //           }
              //           imageFile = file;
              //         },
              //       )
              //     : ImagePickerValueWidget(
              //         label: 'Photo Product',
              //         onChanged: (file) {
              //           if (file == null) {
              //             return;
              //           }
              //           imageFile = file;
              //         },
              //         imageUrl: imageUrl!.contains('http')
              //             ? imageUrl
              //             : "${Variables.baseUrl}$imageUrl",
              //       ),
              const SpaceHeight(20.0),
              CustomTextField(
                controller: stockController!,
                label: 'Stock',
                keyboardType: TextInputType.number,
              ),
              const SpaceHeight(20.0),
              const Text("Category", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700)),
              const SpaceHeight(12.0),
              DropdownButtonHideUnderline(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: DropdownButton<CategoryModel>(
                    value: selectCategory,
                    hint: const Text("Select Category"),
                    isExpanded: true, // Untuk mengisi lebar container
                    onChanged: (newValue) {
                      if (newValue != null) {
                        selectCategory = newValue;
                        setState(() {});
                        log("selectCategory: ${selectCategory!.name}");
                      }
                    },
                    items: categories.map<DropdownMenuItem<CategoryModel>>((
                      CategoryModel category,
                    ) {
                      return DropdownMenuItem<CategoryModel>(
                        value: category,
                        child: Text(category.name),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SpaceHeight(20.0),
              Row(
                children: [
                  Checkbox(
                    value: isBestSeller,
                    onChanged: (value) {
                      setState(() {
                        isBestSeller = value!;
                      });
                    },
                  ),
                  const Text('Favorite Product'),
                ],
              ),
              const SpaceHeight(30.0),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagePickerValueWidget {}

class XFile {}
