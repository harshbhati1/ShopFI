import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopfi/Providers/dataProvider.dart';

class customerDataCard extends ConsumerStatefulWidget {
  final void Function() refresh;
  final Customer customer;
  final CustomerData customerData;
  const customerDataCard(
      {required this.refresh,
      required this.customer,
      required this.customerData,
      super.key});

  @override
  ConsumerState<customerDataCard> createState() => _customerDataCardState();
}

class _customerDataCardState extends ConsumerState<customerDataCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(7),
      child: ExpansionTile(
        title: Text(
            '${widget.customerData.dateChange()} - ${widget.customerData.title}'),
        subtitle: Text('Amount:  ${widget.customerData.amount}'),
        children: [
          ListTile(
            title: Text('Note:  ${widget.customerData.note}'),
          ),
          ListTile(
              leading: const Icon(Icons.check),
              title: const Text('Amount Paid'),
              onTap: () {
                ref
                    .read(dataNotifierProvider.notifier)
                    .addCustomerToPaidCustomerData(
                        context, widget.customer, widget.customerData);
                widget.refresh();
              }),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: () {
              ref.read(dataNotifierProvider.notifier).removeCustomerData(
                  context, widget.customer, widget.customerData);
              widget.refresh();
            },
          ),
        ],
      ),
    );
  }
}
