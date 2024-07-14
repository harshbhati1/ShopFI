import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopfi/Providers/dataProvider.dart';

class customerPaidAmount extends ConsumerStatefulWidget {
  final void Function() refresh;
  final Customer customer;
  final CustomerData customerData;
  const customerPaidAmount({required this.refresh,required this.customer,required this.customerData,super.key});

  @override
  ConsumerState<customerPaidAmount> createState() => _customerPaidAmount();
}

class _customerPaidAmount extends ConsumerState<customerPaidAmount> {
  
  @override
  Widget build(BuildContext context) {
    return Card(
      margin:const EdgeInsets.all(7),
      child: ExpansionTile(
        title: Text('${widget.customerData.dateChange()} - ${widget.customerData.title}'),
        subtitle: Text('Amount:  ${widget.customerData.amount}'),
        children: [
          ListTile(
            title: Text('Note:  ${widget.customerData.note}'),
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Amount Not Paid'),
            onTap: (){
              ref.watch(dataNotifierProvider.notifier).moveBackToCustomerData(context, widget.customer, widget.customerData);
              widget.refresh();
            }),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: (){
               ref.watch(dataNotifierProvider.notifier).deletePaidAmount(context, widget.customer, widget.customerData);
               widget.refresh();
            },
          ),
        ],
      ),
    );
  }
}