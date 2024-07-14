import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopfi/Screen/tabsScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: ShopFi()));
}

final theme = ThemeData(
  useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.teal,
  ),
);

class ShopFi extends StatelessWidget {
  const ShopFi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const tabsScreen(),
    );
  }
}
