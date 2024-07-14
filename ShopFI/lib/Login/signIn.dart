import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopfi/Login/resetPassword.dart';
import 'package:shopfi/Login/reusable.dart';
import 'package:shopfi/Login/signUp.dart';
import 'package:shopfi/Screen/tabsScreen.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  bool isSending = false;
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Log In",
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
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.2,
              20,
              0,
            ),
            child: Column(
              children: <Widget>[
                reusableTextField(
                  Theme.of(context).colorScheme.primary,
                  "Enter UserName",
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
                  Icons.lock_outline,
                  true,
                  _passwordTextController,
                ),
                firebaseUIButton(
                  Theme.of(context).colorScheme.primary,
                  context,
                  isSending ? SizedBox(width: 10, height: 10, child: CircularProgressIndicator(),) : Text("Sign In"),
                  isSending
                      ? () {}
                      : () {
                          setState(() {
                            isSending = true;
                          });
                          FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: _emailTextController.text,
                                  password: _passwordTextController.text)
                              .then((value) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => tabsScreen()));
                          }).onError((error, StackTrace) {
                            setState(() {
                              isSending = false;
                            });
                            String errorMessage = error.toString();
                            // Remove the error code from the error message
                            if (errorMessage.contains('[')) {
                              errorMessage = errorMessage
                                  .substring(errorMessage.indexOf(']') + 1)
                                  .trim();
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(errorMessage),
                                duration: Duration(seconds: 2),
                              ),
                            );
                            print("Error signing in: ${error.toString()}");
                            // Display an error message or handle the error in another way
                          });
                        },
                ),
                firebaseUIButton(
                  Theme.of(context).colorScheme.primary,
                  context,
                  isSending ? SizedBox(width: 10, height: 10, child: CircularProgressIndicator(),) : Text("Forgot Password"),
                  isSending
                      ? () {}
                      : () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword()));
                        },
                ),
                const SizedBox(
                  height: 5,
                ),
                signUpOption(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: isSending
              ? () {}
              : () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Sign_up()));
                },
          child: Text(
            " Sign Up",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
