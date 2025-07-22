import 'package:flutter/material.dart';
import 'package:cashiru/core/components/spaces.dart';
import 'package:cashiru/core/constants/colors.dart';
import 'package:cashiru/presentation/history/widgets/history_transaction_card.dart';

class HistoryTabletPage extends StatefulWidget {
  const HistoryTabletPage({super.key});

  @override
  State<HistoryTabletPage> createState() => _HistoryTabletPageState();
}

class _HistoryTabletPageState extends State<HistoryTabletPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const paddingHorizontal = EdgeInsets.symmetric(horizontal: 16.0);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'History Order',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            // Expanded(
            //   child: ListView.separated(
            //     padding: const EdgeInsets.symmetric(vertical: 28.0),
            //     itemCount: dummyOrders.length,
            //     separatorBuilder: (context, index) => const SpaceHeight(8.0),
            //     itemBuilder: (context, index) => HistoryTransactionCard(
            //       padding: paddingHorizontal,
            //       data: ,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
