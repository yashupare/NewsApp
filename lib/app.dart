import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:inbrief/bindings/general_bindings.dart';
import 'package:inbrief/firststart/onboarding.dart';
import 'package:inbrief/utils/constants/text_strings.dart';
import 'package:inbrief/utils/theme/theme.dart';
import 'package:inbrief/data/repositories/authentication/authentication_repository.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),

      // Loading screen
      home: const Scaffold(backgroundColor: Colors.red, body: Center(child: CircularProgressIndicator(color : Colors.white),),),
    );
  }
}
