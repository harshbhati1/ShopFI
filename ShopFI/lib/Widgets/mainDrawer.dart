import 'package:flutter/material.dart';

class mainDrawer extends StatelessWidget {
  final void Function(String screen) switchDrawerScreen;
  final String userName;
  const mainDrawer({required this.userName,required this.switchDrawerScreen, super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9)
            ])),
            child: Row(
              children: [
                Icon(
                  Icons.person_2_outlined,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                const SizedBox(width: 30),
                Text(
                  userName,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              switchDrawerScreen("home");
            },
            leading: Icon(
              Icons.home,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              "Home",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          ListTile(
            onTap: () {
              switchDrawerScreen("filters");
            },
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              "Filters",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ), Spacer(),
          // Add the "Logout" tab here
          ListTile(
            onTap: () {
              switchDrawerScreen("logout");
            },
            leading: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.primary,
            ),
            title: Text(
              "Logout",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),)
        ],
      ),
    );
  }
}
