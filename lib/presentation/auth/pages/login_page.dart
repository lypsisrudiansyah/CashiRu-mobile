import 'package:cashiru/core/constants/colors.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/presentation/auth/bloc/login/login_bloc.dart';
import 'package:cashiru/presentation/home/pages/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/assets/assets.gen.dart';
import '../../../core/components/buttons.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/components/spaces.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SpaceHeight(80.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 58.0),
            child: Image.asset(Assets.images.logo.path),
          ),

          const SpaceHeight(24.0),
          Center(
            child: Text(
              "Aplikasi Kasir Pilihan Anda",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.black),
            ),
          ),
          const SpaceHeight(20.0),
          const Center(
            child: Text(
              'Login to your account',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Colors.grey),
            ),
          ),
          const SpaceHeight(10.0),
          Container(
            height: 1,
            width: context.deviceWidth * 0.3,
            color: AppColors.grey.withValues(alpha: 0.5),
          ),
          const SpaceHeight(20.0),
          CustomTextField(controller: usernameController, label: 'Email'),
          const SpaceHeight(12.0),
          CustomTextField(controller: passwordController, label: 'Password', obscureText: true),
          const SpaceHeight(24.0),
          BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              switch (state) {
                case Success(data: final loginData):
                  AuthLocalDatasource().saveAuthData(loginData);
                  context.pushReplacement(const DashboardPage());
                  break;
                case Failure(message: final errorMessage):
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(errorMessage), backgroundColor: AppColors.red),
                  );
                  break;
                default:
                  break;
              }
            },
            child: BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                switch (state) {
                  case Loading():
                    return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                  case _:
                    return Button.filled(
                      onPressed: () {
                        context.read<LoginBloc>().add(
                          LoginEvent.login(
                            email: usernameController.text,
                            password: passwordController.text,
                          ),
                        );
                      },
                      label: 'Login',
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
