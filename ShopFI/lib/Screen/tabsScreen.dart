import 'package:flutter/material.dart';
import 'package:shopfi/Providers/dataProvider.dart';
import 'package:shopfi/Screen/mainScreen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class tabsScreen extends ConsumerStatefulWidget {
  const tabsScreen({super.key});

  @override
  ConsumerState<tabsScreen> createState() => _tabsScreenState();
}

class _tabsScreenState extends ConsumerState<tabsScreen> {

  // functionality for changing tabs from bottomnaivigationbar
  int index = 0;
  void _changeIndex(int index) {
    setState(() {
      this.index = index;
    });
  }
  // ends...........   bottomo Navigation Bar

  @override
  Widget build(BuildContext context) {
    // Bottom Navigation Bar functionality
    final actualData = ref.watch(screenNotifierProvider);
    Widget screenInUse = mainScreen(
      isStarredScreen: false,
      availableCustomer: actualData,
    );
    if (index == 1) {
      final starredList = ref.watch(starredNotifierProvider);
      screenInUse = mainScreen(
        isStarredScreen: true,
        availableCustomer: starredList,
      );
    }
    // Bottom Navigattion Bar functionality overs

    return Scaffold(
      body: screenInUse,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            _changeIndex(index);
          },
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), label: "mainScreen"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: "starredCustomer")
          ]),
    );
  }
}
