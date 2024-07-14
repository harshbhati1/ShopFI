import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:shopfi/Providers/dataProvider.dart';
import 'package:shopfi/Widgets/tabBar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class customerCard extends ConsumerStatefulWidget {
  final Customer customer;

  const customerCard({required this.customer, Key? key}) : super(key: key);

  @override
  ConsumerState<customerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends ConsumerState<customerCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onLongPress: () {
          ref
              .read(dataNotifierProvider.notifier)
              .removeCustomer(context, widget.customer);
        },
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => tabBar(
                        customer: widget.customer,
                      )));
        },
        splashColor: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).primaryColor.withOpacity(0.99)
              ],
            ),
          ),
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
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onPrimaryContainer,
                              fontSize: 15,
                            ),
                      ),
                      Text(
                        "Mobile Number: +${widget.customer.number.toString()}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onPrimaryContainer,
                              fontSize: 15,
                            ),
                      ),
                      Text(
                        "Address: ${widget.customer.address}",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onPrimaryContainer,
                              fontSize: 15,
                            ),
                      ),
                    ],
                  ),
             ),
              
              
              Text(
                widget.customer.totalAmount().toStringAsFixed(2),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: widget.customer.totalAmount() >= 0
                          ? Colors.green
                          : Colors.red,
                      fontSize: 40,
                    ),
              ),
            ],
          ),
        ),
    );
  }
}
