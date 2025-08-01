import 'package:cashiru/core/constants/colors.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/presentation/home/widgets/nav_item.dart';
import 'package:cashiru/presentation/tablet/history/pages/history_tablet_page.dart';
import 'package:cashiru/presentation/tablet/home/pages/home_tablet_page.dart';
import 'package:cashiru/presentation/tablet/setting/pages/setting_tablet_page.dart';
import 'package:flutter/material.dart';
import 'package:cashiru/core/assets/assets.gen.dart';
import 'package:cashiru/presentation/auth/pages/login_page.dart';

class DashboardTabletPage extends StatefulWidget {
  const DashboardTabletPage({super.key});

  @override
  State<DashboardTabletPage> createState() => _DashboardTabletPageState();
}

class _DashboardTabletPageState extends State<DashboardTabletPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeTabletPage(),
    const HistoryTabletPage(),
    const SettingTabletPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Row(
          children: [
            SingleChildScrollView(
              child: Container(
                height: context.deviceHeight - 20.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(right: Radius.circular(16.0)),

                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.primary.withOpacity(1),
                      AppColors.primary.withOpacity(0.8), // bisa variasi sesuai kebutuhan
                      AppColors.primary.withOpacity(0.78), // bisa variasi sesuai kebutuhan
                      AppColors.green.withOpacity(0.5), // bisa variasi sesuai kebutuhan
                    ],
                  ),

                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -2),
                      blurRadius: 30.0,
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 0,
                      color: AppColors.black.withOpacity(0.08),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    NavItem(
                      iconPath: Assets.icons.home.path,
                      label: '',
                      isActive: _selectedIndex == 0,
                      onTap: () => _onItemTapped(0),
                      isTablet: true,
                    ),
                    NavItem(
                      iconPath: Assets.icons.history.path,
                      label: '',
                      isActive: _selectedIndex == 1,
                      onTap: () => _onItemTapped(1),
                      isTablet: true,
                    ),

                    NavItem(
                      iconPath: Assets.icons.dashboard.path,
                      label: '',
                      isActive: _selectedIndex == 2,
                      onTap: () => _onItemTapped(2),
                      isTablet: true,
                    ),
                    // NavItem(
                    //   iconPath: Assets.icons.snack.path,
                    //   label: '',
                    //   isActive: _selectedIndex == 3,
                    //   onTap: () => _onItemTapped(3),
                    //   isTablet: true,
                    // ),
                    const Spacer(),
                    Container(
                      margin: const EdgeInsets.all(20.0),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginPage()),
                          );
                        },
                        icon: const Icon(Icons.logout, color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      ),
    );
  }
}
