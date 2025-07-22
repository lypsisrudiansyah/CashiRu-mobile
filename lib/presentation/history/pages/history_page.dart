import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashiru/data/models/response/history_response_model.dart';
import 'package:cashiru/presentation/history/bloc/history/history_bloc.dart';
import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

import '../../../core/components/spaces.dart';

import '../../../data/datasource/auth_local_datasource.dart';
import '../../home/pages/dashboard_page.dart';

import '../widgets/history_transaction_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    context.read<HistoryBloc>().add(const HistoryEvent.fetchHistories());
    _connectDefaultPrinter();
    super.initState();
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
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            context.push(const DashboardPage());
          },
        ),
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocBuilder<HistoryBloc, HistoryState>(
        builder: (context, state) {
          switch (state) {
            case const HistoryState.loading():
              return const Center(child: CircularProgressIndicator());
            case Failure(message: String message):
              return Center(
                child: Text(message, style: const TextStyle(color: Colors.red)),
              );
            case Success(data: HistoryResponseModel data):
              if (data.data == null || data.data!.isEmpty) {
                return const Center(child: Text('No history found'));
              } else {
                final dataList = data.data ?? [];
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  itemCount: dataList.length,
                  separatorBuilder: (context, index) => const SpaceHeight(8.0),
                  itemBuilder: (context, index) => HistoryTransactionCard(
                    padding: paddingHorizontal,
                    data: dataList[index],
                  ),
                );
              }
            default:
              return const Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}
