import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meals2/data/dummy_data.dart';
import 'package:meals2/screens/categories.dart';
import 'package:meals2/screens/meals.dart';
import 'package:meals2/screens/tabs.dart';

void main() {
  runApp( App());
}

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme:GoogleFonts.latoTextTheme()
);

class App extends StatelessWidget{
  App({super.key});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: theme,
      home: TabsScreen(),
    );
  }
}
