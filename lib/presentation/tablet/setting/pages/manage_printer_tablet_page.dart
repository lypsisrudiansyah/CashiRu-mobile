import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cashiru/core/constants/colors.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/core/utils/permission_helper.dart';
import 'package:cashiru/presentation/setting/widgets/menu_printer_button.dart';
import 'package:cashiru/presentation/setting/widgets/menu_printer_content.dart';
import 'package:cashiru/presentation/tablet/setting/widgets/setting_title.dart';

import 'package:print_bluetooth_thermal/print_bluetooth_thermal.dart';

class ManagePrinterTabletPage extends StatefulWidget {
  const ManagePrinterTabletPage({super.key});

  @override
  State<ManagePrinterTabletPage> createState() => _ManagePrinterTabletPageState();
}

class _ManagePrinterTabletPageState extends State<ManagePrinterTabletPage> {
  int selectedIndex = 0;

  String macName = '';

  String _info = "";
  String _msj = '';
  bool connected = false;
  List<BluetoothInfo> items = [];
  final List<String> _options = [
    "permission bluetooth granted",
    "bluetooth enabled",
    "connection status",
    "update info",
  ];

  final String _selectSize = "2";
  final _txtText = TextEditingController(text: "Hello developer");
  bool _progress = false;
  String _msjprogress = "";

  String optionprinttype = "58 mm";
  List<String> options = ["58 mm", "80 mm"];
  String? macConnected;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    loadDataPrinter();
  }

  loadDataPrinter() async {
    if (macConnected != '') {
      macName = macConnected!;
      await connect(macName);
    }
    log('macConnected: $macConnected');
    getBluetoots();
    setState(() {});
  }

  Future<void> initPlatformState() async {
    PermissionHelper().permissionPrinter();
    String platformVersion;
    int porcentbatery = 0;
    try {
      platformVersion = await PrintBluetoothThermal.platformVersion;
      log("patformversion: $platformVersion");
      porcentbatery = await PrintBluetoothThermal.batteryLevel;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    final bool result = await PrintBluetoothThermal.bluetoothEnabled;
    log("bluetooth enabled: $result");
    if (result) {
      _msj = "Bluetooth enabled, please search and connect";
    } else {
      _msj = "Bluetooth not enabled";
    }

    setState(() {
      _info = "$platformVersion ($porcentbatery% battery)";
    });
  }

  Future<void> getBluetoots() async {
    setState(() {
      _progress = true;
      _msjprogress = "Wait";
      items = [];
    });
    final List<BluetoothInfo> listResult = await PrintBluetoothThermal.pairedBluetooths;

    setState(() {
      _progress = false;
    });

    if (listResult.isEmpty) {
      _msj = "There are no bluetoohs linked, go to settings and link the printer";
    } else {
      _msj = "Touch an item in the list to connect";
    }

    setState(() {
      items = listResult;
    });
  }

  Future<void> connect(String mac) async {
    setState(() {
      _progress = true;
      _msjprogress = "Connecting...";
      connected = false;
    });
    final bool result = await PrintBluetoothThermal.connect(macPrinterAddress: mac);
    log("state conected $result");
    connected = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Printer connected with Name $mac'),
        backgroundColor: AppColors.primary,
      ),
    );
    if (result) connected = true;
    setState(() {
      _progress = false;
    });
  }

  Future<void> disconnect() async {
    final bool status = await PrintBluetoothThermal.disconnect;
    setState(() {
      connected = false;
    });
    log("status disconnect $status");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          const SettingsTitle('Manage Printer'),
          const SizedBox(height: 24),
          // DropdownButton<String>(
          //   value: optionprinttype,
          //   items: options.map((String value) {
          //     return DropdownMenuItem<String>(
          //       value: value,
          //       child: Text(value),
          //     );
          //   }).toList(),
          //   onChanged: (String? newValue) {
          //     setState(() {
          //       optionprinttype = newValue!;
          //     });
          //   },
          // ),
          Container(
            width: context.deviceWidth / 2,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                MenuPrinterButton(
                  label: 'Search',
                  onPressed: () {
                    getBluetoots();
                    selectedIndex = 0;
                    setState(() {});
                  },
                  isActive: selectedIndex == 0,
                ),
                MenuPrinterButton(
                  label: 'Disconnect',
                  onPressed: () {
                    selectedIndex = 1;
                    setState(() {});
                  },
                  isActive: selectedIndex == 1,
                ),
                MenuPrinterButton(
                  label: 'Test',
                  onPressed: () {
                    selectedIndex = 2;
                    setState(() {});
                  },
                  isActive: selectedIndex == 2,
                ),
              ],
            ),
          ),
          const SizedBox(height: 34.0),
          _Body(
            macName: macName,
            datas: items,
            clickHandler: (mac) async {
              macName = mac;
              await connect(mac);
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final String macName;
  final List<BluetoothInfo> datas;

  final Function(String) clickHandler;

  const _Body({required this.macName, required this.datas, required this.clickHandler});

  @override
  Widget build(BuildContext context) {
    if (datas.isEmpty) {
      return const Text('No data available');
    } else {
      return Container(
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: datas.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16.0),
          itemBuilder: (context, index) => InkWell(
            onTap: () {
              clickHandler(datas[index].macAdress);
            },
            child: MenuPrinterContent(
              isSelected: macName == datas[index].macAdress,
              data: datas[index],
            ),
          ),
        ),
      );
    }
  }
}
