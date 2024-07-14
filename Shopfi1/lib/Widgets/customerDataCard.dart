import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';

class customerDataCard extends StatefulWidget {
  final Customer customer;
  final CustomerData customerData;
  final void Function(String functionName, CustomerData customerData)  customerCardDataFunctions;
  const customerDataCard({required this.customerCardDataFunctions,required this.customer,required this.customerData,super.key});

  @override
  State<customerDataCard> createState() => _customerDataCardState();
}

class _customerDataCardState extends State<customerDataCard> {
  
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
            leading: const Icon(Icons.check),
            title: const Text('Amount Paid'),
            onTap: (){
              widget.customerCardDataFunctions("amountPaid", widget.customerData);
            }),
          ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Delete'),
            onTap: (){
              widget.customerCardDataFunctions("deleteCustomerCard", widget.customerData);
            },
          ),
        ],
      ),
    );
  }
}