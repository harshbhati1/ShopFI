import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:shopfi/Widgets/tabBar.dart';

class customerCard extends StatefulWidget {
   final void Function(String function, Customer customer) starredCustomerFunction;
  final void Function(Customer customer) customerRemove;
  final void Function(String functionName, Customer customer, CustomerData customerData)  customerCardDataFunctions;
  final Customer customer;


  const customerCard(
      {required this.starredCustomerFunction,required this.customerRemove,required this.customerCardDataFunctions, required this.customer,
      Key? key})
      : super(key: key);

  @override
  State<customerCard> createState() => _CustomerCardState();
}

class _CustomerCardState extends State<customerCard> {
  
 

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: (){
        widget.customerRemove(widget.customer);
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => tabBar(starredCustomerFunction: widget.starredCustomerFunction,customerCardDataFunctions: widget.customerCardDataFunctions, customer: widget.customer,
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
            const SizedBox(width: 20), // Adjust the spacing between the money and other details
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
