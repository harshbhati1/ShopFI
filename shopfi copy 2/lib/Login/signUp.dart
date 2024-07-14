import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopfi/Login/reusable.dart';
import 'package:shopfi/Screen/tabsScreen.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _userNameTextController = TextEditingController();
  bool isSending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Sign Up",
          style: Theme.of(context)
              .textTheme
              .displayMedium!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  Theme.of(context).colorScheme.primary,
                  "Enter UserName",
                  Icons.person_outline,
                  false,
                  _userNameTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  Theme.of(context).colorScheme.primary,
                  "Enter Email Id",
                  Icons.person_outline,
                  false,
                  _emailTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                reusableTextField(
                  Theme.of(context).colorScheme.primary,
                  "Enter Password",
                  Icons.lock_outlined,
                  true,
                  _passwordTextController,
                ),
                const SizedBox(
                  height: 20,
                ),
                firebaseUIButton(
                  Theme.of(context).colorScheme.primary,
                  context,
                  isSending
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        )
                      : Text("Sign Up"),
                  () {
                    setState(() {
                      isSending = true;
                    });
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text,
                    )
                        .then((value) {
                      print('User UID: ${value.user!.uid}');
                      CollectionReference collRef =
                          FirebaseFirestore.instance.collection('client');
                      collRef.doc(value.user!.uid).set({
                        'name': _userNameTextController.text,
                        'email': _emailTextController.text,
                      }).then((_) {
                        print("Created New Account");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => tabsScreen(),
                          ),
                        );
                      });
                    }).catchError((error) {
                      setState(() {
                        isSending = false;
                      });
                      String errorMessage = error.toString();
                      if (errorMessage.contains('[')) {
                        errorMessage = errorMessage
                            .substring(errorMessage.indexOf(']') + 1)
                            .trim();
                      }
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(errorMessage),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      print("Error signing in: ${error.toString()}");
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
