import 'package:bus_tracing/Feature/Providers/AuthProvider.dart';
import 'package:bus_tracing/Feature/Providers/LineProvider.dart';
import 'package:bus_tracing/Feature/Views/OnboardingScreen/OnboardingScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Core/ColorsManager.dart';
import 'Feature/Providers/GlobalProvider.dart';
import 'Feature/Views/LoginScreen/LoginScreen.dart';
import 'Network/dioHelper.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
  DioHelper.CraeteDio();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) {
          return GlobalProvider()..getLength();
        }),
        ChangeNotifierProvider(create: (ctx) {
          return AuthProvider();
        }),
        ChangeNotifierProvider(create: (ctx) {
          return LineProvider();
        }),
      ],
      builder: (ctx, child) {
        // var globalProvider = Provider.of<GlobalProvider>(ctx);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0XFF2C2B34),
          ),
          home: LoginScreen(),
        );
      },
    );
  }
}
