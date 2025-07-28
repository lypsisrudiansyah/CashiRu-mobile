import 'package:cashiru/core/constants/colors.dart';
import 'package:cashiru/core/depedency_injection/service_locator.dart';
import 'package:cashiru/core/extensions/build_context_extension.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/presentation/auth/bloc/login/login_bloc.dart';
import 'package:cashiru/presentation/auth/bloc/logout/logout_bloc.dart';
import 'package:cashiru/presentation/auth/pages/login_page.dart';
import 'package:cashiru/presentation/history/bloc/history/history_bloc.dart';
import 'package:cashiru/presentation/home/bloc/category/category_bloc.dart';
import 'package:cashiru/presentation/home/bloc/checkout/checkout_bloc.dart';
import 'package:cashiru/presentation/home/bloc/product/product_bloc.dart';
import 'package:cashiru/presentation/home/pages/dashboard_page.dart';
import 'package:cashiru/presentation/order/bloc/order/order_bloc.dart';
import 'package:cashiru/presentation/tablet/home/pages/dashboard_tablet_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // calling BLoc also given GetIt ServiceLocator
        BlocProvider(create: (_) => getIt<LoginBloc>()),
        BlocProvider(create: (_) => getIt<CategoryBloc>()),
        BlocProvider(create: (_) => getIt<LogoutBloc>()),
        BlocProvider(create: (_) => getIt<ProductBloc>()),
        BlocProvider(create: (_) => getIt<CheckoutBloc>()),
        BlocProvider(create: (_) => getIt<OrderBloc>()),
        BlocProvider(create: (_) => getIt<HistoryBloc>()),
      ],
      child: MaterialApp(
        title: 'CashiRu',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
          appBarTheme: AppBarTheme(
            color: AppColors.primary,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(color: AppColors.primary),
          ),
        ),
        home: FutureBuilder<bool>(
          // future: AuthLocalDatasource().isAuthenticated(),
          future: Future.delayed(
            Duration(milliseconds: 0),
            () => AuthLocalDatasource().isAuthenticated(),
          ).then((value) => value),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                backgroundColor: Colors.white,
                body: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasData && snapshot.data!) {
              if (context.deviceWidth >= 600) {
                // & Already Tablet
                return DashboardTabletPage();
              }
              return DashboardPage();
            } else {
              return LoginPage();
            }
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$_counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
