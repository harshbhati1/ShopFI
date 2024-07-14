import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopfi/Login/loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopfi/firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
).then((value) => null);
  runApp(const ProviderScope(child: ShopFi()));
}


// final theme = ThemeData(
//   useMaterial3: true,
//   textTheme: GoogleFonts.latoTextTheme(),
//   colorScheme: ColorScheme.fromSeed(
//     brightness: Brightness.dark,
//     seedColor: Colors.white,
//   ),
// );

final theme  = ThemeData(
   useMaterial3: true,
  textTheme: GoogleFonts.latoTextTheme(),
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: Colors.teal,
  ),);


class ShopFi extends StatelessWidget {
  const ShopFi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const loading(),
      
    );
  }
}
