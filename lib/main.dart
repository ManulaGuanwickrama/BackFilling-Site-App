import 'package:firebase_core/firebase_core.dart';
import 'package:first_try_backfilling/screens/client/client_home_page.dart';
import 'package:first_try_backfilling/screens/client/client_layer_screen.dart';
import 'package:first_try_backfilling/screens/constructor/constructor_layer_screen.dart';
import 'package:first_try_backfilling/screens/constructor/contructor_home_page.dart';
import 'package:first_try_backfilling/screens/consultant/consultant_home_page.dart';
import 'package:first_try_backfilling/screens/consultant/create_project.dart';
import 'package:first_try_backfilling/screens/consultant/consultant_layers_screen.dart';
import 'package:first_try_backfilling/screens/consultant/requests_screen.dart';
import 'package:first_try_backfilling/screens/projects_screen.dart';
import 'package:first_try_backfilling/screens/sections_screen.dart';
import 'package:first_try_backfilling/screens/consultant/test_enter_screen.dart';
import 'package:first_try_backfilling/screens/consultant/test_screen.dart';
import 'package:first_try_backfilling/screens/login_screen.dart';
import 'package:first_try_backfilling/screens/register_screen.dart';
import 'package:first_try_backfilling/screens/user_page.dart';
import 'package:flutter/material.dart';
import 'package:first_try_backfilling/screens/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Backfilling());
}

class Backfilling extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ConsultantHomePage.id: (context) => ConsultantHomePage(),
        CreateProjectScreen.id: (context) => CreateProjectScreen(),
        ProjectsScreen.id: (context) => ProjectsScreen(),
        SectionsScreen.id: (context) => SectionsScreen(),
        ConsultantLayersScreen.id: (context) => ConsultantLayersScreen(),
        TestEnterScreen.id: (context) => TestEnterScreen(),
        TestScreen.id: (context) => TestScreen(),
        ClientHomePage.id: (context) => ClientHomePage(),
        ConstructorHomePage.id: (context) => ConstructorHomePage(),
        UserPage.id: (context) => UserPage(),
        ConstructorLayersScreen.id: (context) => ConstructorLayersScreen(),
        RequestsScreen.id: (context) => RequestsScreen(),
        ClientLayersScreen.id: (context) => ClientLayersScreen(),
      },
    );
  }
}
