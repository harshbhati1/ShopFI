import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:shopfi/Providers/dataProvider.dart';
import 'package:shopfi/Widgets/customerCard.dart';
import 'package:shopfi/Widgets/customerDataCard.dart';
import 'package:shopfi/Widgets/customerPaidAmount%20copy.dart';
import 'package:shopfi/Widgets/overlayWidgetCustomerCard.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class tabBar extends ConsumerStatefulWidget {
  final Customer customer;
  const tabBar({required this.customer, super.key});

  @override
  ConsumerState<tabBar> createState() => _tabBarState();
}

class _tabBarState extends ConsumerState<tabBar> {
  Color starColor = Colors.grey;

  void refreshTabBar() {
    setState(() {}); // Simply call setState to trigger a rebuild of the tabBar
  }

  @override
  Widget build(BuildContext context) {
    starColor = widget.customer.isStarred ? Colors.amber : Colors.grey;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "${widget.customer.name}'s Log",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                  color: Theme.of(context).colorScheme.primary, fontSize: 30),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    if (starColor == Colors.grey) {
                      ref
                          .read(starredNotifierProvider.notifier)
                          .addCustomerToStarred(context, widget.customer);
                      refreshTabBar();
                    } else if (starColor == Colors.amber) {
                      ref
                          .read(starredNotifierProvider.notifier)
                          .removeCustomerToStarred(context, widget.customer);
                      refreshTabBar();
                    }
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.star,
                      color: starColor,
                      key: ValueKey(widget.customer.isStarred),
                    ),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  )),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => (OverlayWidgetCustomerCard(
                          refresh: refreshTabBar, customer: widget.customer)),
                      useSafeArea: true);
                },
                icon: Icon(
                  Icons.add,
                  size: 35,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
          body: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.9)
                ])),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Name: ${widget.customer.name}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 18,
                                        ),
                                  ),
                                  Text(
                                    "Mobile Number: +${widget.customer.number.toString()}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 18,
                                        ),
                                  ),
                                  Text(
                                    "Address: ${widget.customer.address}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onBackground,
                                          fontSize: 18,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              widget.customer.totalAmount().toStringAsFixed(2),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: widget.customer.totalAmount() >= 0
                                        ? Colors.green
                                        : Colors.red,
                                    fontSize: 40,
                                  ),
                            ),
                          ],
                        ),
                      )
                    ]),
              ),
              TabBar(
                  indicatorColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.query_builder),
                    ),
                    Tab(
                      icon: Icon(Icons.done),
                    )
                  ]),
              Expanded(
                child: TabBarView(children: [
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          for (final data in widget.customer.customerData)
                            customerDataCard(
                              refresh: refreshTabBar,
                              customer: widget.customer,
                              customerData: data,
                            )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          for (final data
                              in widget.customer.completedCustomerData)
                            customerPaidAmount(
                              refresh: refreshTabBar,
                              customer: widget.customer,
                              customerData: data,
                            )
                        ],
                      ),
                    ),
                  )
                ]),
              )
            ],
          )),
    );
  }
}
