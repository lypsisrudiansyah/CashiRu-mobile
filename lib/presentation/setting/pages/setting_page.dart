import 'package:cashiru/presentation/setting/pages/manage_printer_page.dart';
import 'package:cashiru/presentation/setting/pages/report_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cashiru/core/constants/colors.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:cashiru/presentation/auth/pages/login_page.dart';

import 'package:cashiru/presentation/home/pages/dashboard_page.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/menu_button.dart';
import '../../../core/components/spaces.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            context.push(const DashboardPage());
          },
        ),
        centerTitle: true,
        title: const Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SpaceHeight(20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Flexible(
                    child: MenuButton(
                      iconPath: Assets.icons.chart.path,
                      label: 'Report',
                      onPressed: () {
                        // Navigate to ReportPage
                        // You can replace this with your actual report page navigation
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ReportPage()),
                        );
                      },

                      // => context.push(const ReportPage()),
                      isImage: false,
                    ),
                  ),
                  const SpaceWidth(15.0),
                  Flexible(
                    child: MenuButton(
                      iconPath: Assets.icons.print.path,
                      label: 'Setting Printer',
                      onPressed: () {
                        context.push(const ManagePrinterPage());
                      },
                      isImage: false,
                    ),
                  ),
                ],
              ),
            ),
            const SpaceHeight(60),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {
                  //clear auth
                  // AuthLocalDatasource().clearAuthData();
                  context.read<LogoutBloc>().add(LogoutEvent.logout());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                child: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
