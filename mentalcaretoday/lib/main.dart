import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mentalcaretoday/src/UI/views/home_screen.dart';
import 'package:mentalcaretoday/src/UI/views/splash_screen.dart';
import 'package:mentalcaretoday/src/provider/payment_provider.dart';
import 'package:mentalcaretoday/src/routes/router.dart';
import 'package:mentalcaretoday/src/services/auth_services.dart';
import 'package:provider/provider.dart';

import 'src/provider/other_user_provider.dart';
import 'src/provider/user_provider.dart';
import 'src/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OtherUserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PaymentProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  bool isLoading = false;
  void loadData() async {
    setState(() {
      isLoading = true;
    });

    await authService.getUserData(context);
    setState(() {
      isLoading = false;
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mental Care Today',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: MyRouter().generateRoute,
      home: isLoading
          ? Scaffold(
              backgroundColor: Color(0xFF7EC2DC),
              body: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                  height: 80,
                ),
              ),
            )
          : Provider.of<UserProvider>(context).user.id == 0
              ? const SplashScreen()
              : const HomeScreen(),
    );
  }
}
