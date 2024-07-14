import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:shopfi/Screen/filtersScreen.dart';
import 'package:shopfi/Widgets/customerCard.dart';
import 'package:shopfi/Widgets/mainDrawer.dart';
import 'package:shopfi/Widgets/mainScreenContainer.dart';
import 'package:shopfi/Widgets/overlayWidgetCustomer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class mainScreen extends ConsumerStatefulWidget {
  final List<Customer> availableCustomer;
  final bool isStarredScreen;

  const mainScreen(
      {required this.isStarredScreen,
      required this.availableCustomer,
      super.key});

  @override
  ConsumerState<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends ConsumerState<mainScreen> {
  

  // drawer functionality
  void _switchDrawerScreen(String screen) {
    Navigator.of(context).pop();
    if (screen == "filters") {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    }
  }
  // drawer functionality ends

  @override
  Widget build(BuildContext context) {
    double amountBorrowed = 0.0;
    double amountGiven = 0.0;
    for (final customer in widget.availableCustomer) {
      if (customer.totalAmount() >= 0) {
        amountGiven += customer.totalAmount();
      } else {
        amountBorrowed += customer.totalAmount();
      }
    }

    return Scaffold(
        appBar: AppBar(
            title: Text(
              "ShopFi",
              style: Theme.of(context)
                  .textTheme
                  .displayLarge!
                  .copyWith(color: Theme.of(context).colorScheme.primary),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const overlayWidgetCustomer(),
                      useSafeArea: true);
                },
                icon: Icon(
                  Icons.add,
                  size: 35,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 20),
            ]),
        drawer: mainDrawer(
          switchDrawerScreen: _switchDrawerScreen,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          widget.isStarredScreen ? Container(): mainScreenContainer(
                  amountBorrowed: amountBorrowed, amountGiven: amountGiven),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.isStarredScreen ? " Starred Customers" : "Customers",
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 10,
          ),
          for (final customer in widget.availableCustomer)
            customerCard(customer: customer)
        ])));
  }
}
