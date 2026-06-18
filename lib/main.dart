import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'auth/auth_notifier.dart';
import 'screens/auth/sign_in.dart';
import 'screens/auth/sign_up_page.dart';
import 'screens/home/home_page.dart';
import 'screens/products/medicine_page.dart';
import 'screens/products/men_page.dart';
import 'screens/products/skincare_page.dart';
import 'screens/admin/add_employee_page.dart';
import 'screens/contact_us_page.dart';
import 'screens/review_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthNotifier(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pharmacy App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/view',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff013220)),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => SignInPage(),
        '/signup': (context) => SignUpPage(),
        '/Add': (context) => AddEmployeePage(),
        '/view': (context) => HomePage(),
        '/medicine': (context) => MedicinePage(),
        '/men': (context) => MenPage(),
        '/shoes': (context) => SkincarePage(),
        '/contact': (context) => ContactUsPage(),
        '/FeedBack': (context) => ReviewPage(),
      },
    );
  }
}
