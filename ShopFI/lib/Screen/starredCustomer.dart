import 'package:flutter/material.dart';

class starredCustomer extends StatelessWidget {
  const starredCustomer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Starred",
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        centerTitle: true,
      ),
    );
  }
}
