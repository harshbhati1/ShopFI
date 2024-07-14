import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';

class customerPaidAmount extends StatefulWidget {
  final Customer customer;
  final CustomerData customerData;
  final void Function(String functionName, CustomerData customerData)  customerCardDataFunctions;
  const customerPaidAmount({required this.customerCardDataFunctions,required this.customer,required this.customerData,super.key});

  @override
  State<customerPaidAmount> createState() => _customerPaidAmount();
}

class _customerPaidAmount extends State<customerPaidAmount> {
  
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
             widget.customerCardDataFunctions("amountNotPaid", widget.customerData);
            }),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: (){
               widget.customerCardDataFunctions("deleteAmountPaid", widget.customerData);
            },
          ),
        ],
      ),
    );
  }
}