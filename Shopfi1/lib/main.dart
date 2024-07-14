import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopfi/Screen/tabsScreen.dart';
void main(){
  runApp(const ShopFi());
}


/// appTheme 

final theme = ThemeData(
  useMaterial3: true,
   textTheme: GoogleFonts.latoTextTheme(),
  colorScheme: ColorScheme.fromSeed(
     brightness: Brightness.dark,
    seedColor: Colors.teal)
);

// appTheme ends 

//mainFile code starts 
class ShopFi extends StatelessWidget {
  const ShopFi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: tabsScreen(),
    );
  }
}