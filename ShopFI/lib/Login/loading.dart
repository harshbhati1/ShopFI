import 'package:flutter/material.dart';
import 'package:shopfi/Login/signIn.dart';

class loading extends StatefulWidget {
  const loading({super.key});

  @override
  State<loading> createState() => _loadingState();
}


class _loadingState extends State<loading> {
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(seconds: 2),(){
 Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const Sign_in()), (route) => false);
    });
    super.initState();
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/Logo.png"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
  }
}