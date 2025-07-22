import 'dart:convert';
import 'dart:developer';

import 'package:cashiru/data/models/response/product_sales_response_model.dart';
import 'package:flutter/material.dart';

import 'package:cashiru/core/components/spaces.dart';
import 'package:cashiru/core/constants/colors.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/core/extensions/int_extension.dart';
import 'package:cashiru/core/extensions/string_extension.dart';
import 'package:cashiru/presentation/tablet/setting/widgets/setting_title.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:intl/intl.dart';

import '../../../../core/components/buttons.dart';

class ReportTabletPage extends StatefulWidget {
  const ReportTabletPage({super.key});

  @override
  State<ReportTabletPage> createState() => _ReportTabletPageState();
}

class _ReportTabletPageState extends State<ReportTabletPage> {
  DateTime selectedStartDate = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime selectedEndDate = DateTime.now();
  List<ProductSales> productSales = [];
  Summary? summary;

  @override
  void initState() {
    super.initState();
    String startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate);
    String endDate = DateFormat('yyyy-MM-dd').format(selectedEndDate);
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedStartDate) {
      setState(() {
        selectedStartDate = picked;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedEndDate) {
      setState(() {
        selectedEndDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SettingsTitle('Report'),
              const SpaceHeight(24),
              Row(
                children: [
                  Row(
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy').format(selectedStartDate),
                        style: const TextStyle(color: AppColors.primary, fontSize: 12.0),
                      ),
                      IconButton(
                        onPressed: () => _selectStartDate(context),
                        icon: const Icon(Icons.calendar_month, color: AppColors.primary),
                      ),
                    ],
                  ),
                  SpaceWidth(context.deviceWidth * 0.04),
                  const Text('-'),
                  SpaceWidth(context.deviceWidth * 0.04),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd MMM yyyy').format(selectedEndDate),
                        style: const TextStyle(color: AppColors.primary, fontSize: 12.0),
                      ),
                      IconButton(
                        onPressed: () => _selectEndDate(context),
                        icon: const Icon(Icons.calendar_month, color: AppColors.primary),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      SizedBox(
                        width: 160,
                        child: Button.filled(
                          onPressed: () {
                            String startDate = DateFormat('yyyy-MM-dd').format(selectedStartDate);
                            String endDate = DateFormat('yyyy-MM-dd').format(selectedEndDate);
                          },
                          label: "Filter",
                        ),
                      ),
                    ],
                  ),
                  const SpaceWidth(16),
                  PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'PDF') {
                        log("PDF");
                        // if (productSales.isNotEmpty && summary != null) {
                        //   log('PDF selected');
                        //   final status =
                        //       await PermissionHelper().checkPermission();
                        //   if (status.isGranted) {
                        //     final pdfFile =
                        //         await Invoice.generate(productSales, summary!);
                        //     log("pdfFile: $pdfFile");
                        //     HelperPdfService.openFile(pdfFile);
                        //   }
                        // }
                      } else if (value == 'Excel') {
                        // log("Excel");
                        // generateExcel(productSales, summary!);
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return {'PDF', 'Excel'}.map((String choice) {
                        return PopupMenuItem<String>(value: choice, child: Text(choice));
                      }).toList();
                    },
                    icon: const Icon(Icons.more_vert, color: AppColors.primary),
                  ),
                ],
              ),
              const SpaceHeight(16.0),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.card.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SettingsTitle("Summary"),
                    const SpaceHeight(16.0),
                    Column(
                      children: [
                        buildPrice('Total Quantity', '1'),
                        const SpaceHeight(8),
                        buildPrice('Total', '10000000'),
                        const SpaceHeight(8),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Sold Items", style: TextStyle(color: AppColors.primary)),
                            Text(
                              "1 items",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SpaceHeight(16),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColors.white,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.card.withValues(alpha: 0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SettingsTitle("Product Sales"),
                    const SpaceHeight(16.0),
                    Column(
                      children: [
                        // * Try This - Should Be Implement
                        tableProductSales(dummyProductSalesResponse),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                "Total",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              Text(
                                "10",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SpaceWidth(24),
                              Text(
                                "1000000",
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPrice(String title, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(color: AppColors.primary)),
        Text(
          int.parse(value).currencyFormatRp,
          style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
        ),
      ],
    );
  }

  final ProductSalesResponseModel dummyProductSalesResponse = ProductSalesResponseModel(
    status: "success",
    data: [
      ProductSales(
        productId: 101,
        productName: "Nasi Goreng Spesial",
        productPrice: 25000,
        totalQuantity: "35", // Total terjual 35 porsi
        total: (25000 * 35).toString(), // "875000"
      ),
      ProductSales(
        productId: 303,
        productName: "Kopi Susu Gula Aren",
        productPrice: 22000,
        totalQuantity: "52", // Total terjual 52 gelas
        total: (22000 * 52).toString(), // "1144000"
      ),
      ProductSales(
        productId: 102,
        productName: "Sate Ayam Madura",
        productPrice: 30000,
        totalQuantity: "28", // Total terjual 28 porsi
        total: (30000 * 28).toString(), // "840000"
      ),
      ProductSales(
        productId: 201,
        productName: "Pisang Goreng Keju",
        productPrice: 15000,
        totalQuantity: "45", // Total terjual 45 porsi
        total: (15000 * 45).toString(), // "675000"
      ),
    ],
  );

  List<Widget> _getTitleHeaderWidget() {
    return [
      _getTitleItemWidget('No', 68),
      _getTitleItemWidget('ID', 68),
      _getTitleItemWidget('Product', 160),
      _getTitleItemWidget('Price', 160),
      _getTitleItemWidget('Quantity', 68),
      _getTitleItemWidget('Total', 160),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      width: width,
      height: 56,
      color: AppColors.primary,
      alignment: Alignment.centerLeft,
      child: Center(
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget tableProductSales(ProductSalesResponseModel data) {
    const double itemHeight = 55.0;
    final double tableHeight = itemHeight * data.data.length;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: SizedBox(
        height: tableHeight + itemHeight,
        child: HorizontalDataTable(
          leftHandSideColumnWidth: 68,
          rightHandSideColumnWidth: 616,
          isFixedHeader: true,
          headerWidgets: _getTitleHeaderWidget(),
          leftSideItemBuilder: (context, index) {
            return Container(
              width: 68,
              height: 52,
              alignment: Alignment.centerLeft,
              child: Center(child: Text((index + 1).toString())),
            );
          },
          rightSideItemBuilder: (context, index) {
            final productSales = data.data[index];
            return Row(
              children: <Widget>[
                Container(
                  width: 68,
                  height: 52,
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Center(child: Text(productSales.productId.toString())),
                ),
                Container(
                  width: 160,
                  height: 52,
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Center(child: Text(productSales.productName)),
                ),
                Container(
                  width: 160,
                  height: 52,
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Center(child: Text(productSales.productPrice.currencyFormatRp)),
                ),
                Container(
                  width: 68,
                  height: 52,
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Center(child: Text(productSales.totalQuantity.toString())),
                ),
                Container(
                  width: 160,
                  height: 52,
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  alignment: Alignment.centerLeft,
                  child: Center(child: Text(productSales.total.toIntegerFromText.currencyFormatRp)),
                ),
              ],
            );
          },
          itemCount: data.data.length,
          rowSeparatorWidget: const Divider(color: AppColors.black, height: 1.0, thickness: 0.0),
          leftHandSideColBackgroundColor: AppColors.white,
          rightHandSideColBackgroundColor: AppColors.white,
          itemExtent: 55,
        ),
      ),
    );
  }
}

class SummaryResponseModel {
  final String status;
  final Summary data;

  SummaryResponseModel({required this.status, required this.data});

  factory SummaryResponseModel.fromMap(Map<String, dynamic> map) {
    return SummaryResponseModel(
      status: map['status'] as String,
      data: Summary.fromMap(map['data'] as Map<String, dynamic>),
    );
  }

  factory SummaryResponseModel.fromJson(String source) =>
      SummaryResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

class Summary {
  final int totalRevenue;
  final int totalSoldQuantity;

  Summary({required this.totalRevenue, required this.totalSoldQuantity});

  factory Summary.fromMap(Map<String, dynamic> map) {
    return Summary(
      totalRevenue: map['total_revenue'] as int,
      totalSoldQuantity: map['total_sold_quantity'] is String
          ? int.parse(map['total_sold_quantity'])
          : map['total_sold_quantity'],
    );
  }

  factory Summary.fromJson(String source) =>
      Summary.fromMap(json.decode(source) as Map<String, dynamic>);
}
