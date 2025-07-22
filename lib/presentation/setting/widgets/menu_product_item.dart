// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/data/models/response/product_response_model.dart';


import '../../../core/components/buttons.dart';
import '../../../core/components/spaces.dart';
import '../../../core/constants/colors.dart';
import '../../../core/constants/variables.dart';

class MenuProductItem extends StatelessWidget {
  final bool isTablet;
  final Product data;
  final Function() onTapEdit;
  const MenuProductItem({
    super.key,
    required this.data,
    required this.onTapEdit,
    this.isTablet = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 3, color: AppColors.blueLight),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: isTablet
          ? Column(
              children: buildList(context),
            )
          : Row(children: buildList(context)),
    );
  }

  List<Widget> buildList(BuildContext context) {
    return [
      isTablet
          ? Stack(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    child: CachedNetworkImage(
                      imageUrl:  '${Variables.baseUrl}${data.image}',
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(
                        Icons.food_bank_outlined,
                        size: 80,
                      ),
                      width: context.deviceWidth,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () async {
                        await showDialog<void>(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm'),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        'Are you sure you want to delete ${data.name}?'),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.red),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    "No",
                                    style: TextStyle(color: AppColors.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.cancel,
                        color: AppColors.red,
                      )),
                ),
              ],
            )
          : ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              child: CachedNetworkImage(
                imageUrl:  '${Variables.baseUrl}${data.image}',
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(
                  Icons.food_bank_outlined,
                  size: 80,
                ),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
      const SpaceWidth(22.0),
      Flexible(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isTablet
                ? Text(
                    data.name ?? 'No Name',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: context.deviceWidth * 0.5,
                        child: Text(
                          data.name ?? 'No Name',
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                          onPressed: () async {
                            await showDialog<void>(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Confirm'),
                                  content: SingleChildScrollView(
                                    child: ListBody(
                                      children: <Widget>[
                                        Text(
                                            'Are you sure you want to delete ${data.name}?'),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.red),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        "No",
                                        style:
                                            TextStyle(color: AppColors.white),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: AppColors.red,
                          ))
                    ],
                  ),
            const SpaceHeight(5.0),
            Text(
              data.categoryId.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            const SpaceHeight(10.0),
            Row(
              children: [
                Flexible(
                  child: Button.outlined(
                    onPressed: () {
                      showDialog(
                          context: context,
                          // backgroundColor: AppColors.white,
                          builder: (context) {
                            //container for product detail
                            return AlertDialog(
                              contentPadding: const EdgeInsets.all(16.0),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        data.name ?? 'No Name',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(Icons.close),
                                      ),
                                    ],
                                  ),
                                  const SpaceHeight(10.0),
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          '${Variables.baseUrl}${data.image}',
                                      placeholder: (context, url) =>
                                          const Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.food_bank_outlined,
                                        size: 80,
                                      ),
                                      width: 80,
                                    ),
                                  ),
                                  const SpaceHeight(10.0),
                                  Text(
                                    data.categoryId.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SpaceHeight(10.0),
                                  Text(
                                    data.price.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SpaceHeight(10.0),
                                  Text(
                                    data.stock.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SpaceHeight(10.0),
                                ],
                              ),
                            );
                          });
                    },
                    label: 'Detail',
                    fontSize: 8.0,
                    height: 31,
                  ),
                ),
                const SpaceWidth(6.0),
                Flexible(
                  child: Button.outlined(
                    onPressed: onTapEdit,
                    label: 'Edit',
                    fontSize: 8.0,
                    height: 31,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ];
  }
}
