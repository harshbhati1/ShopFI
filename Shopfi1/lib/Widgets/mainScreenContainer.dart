import 'package:flutter/material.dart';

class mainScreenContainer extends StatefulWidget {
  final double amountGiven;
  final double amountBorrowed;
  const mainScreenContainer({
    required this.amountBorrowed,
    required this.amountGiven,
    Key? key,
  }) : super(key: key);

  @override
  State<mainScreenContainer> createState() => _mainScreenContainerState();
}

class _mainScreenContainerState extends State<mainScreenContainer> {
  @override
  Widget build(BuildContext context) {
    double totalAmount = widget.amountGiven + widget.amountBorrowed;
    return Container(
      width: double.infinity,
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             Text(
                "Total Amount :",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontSize: 30
                    ),
              ),
              Text(
                totalAmount.toStringAsFixed(2),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: totalAmount>=0? Colors.green: Colors.red,
                      fontSize: 30
                    ),
              ),
          ],),
             const SizedBox(height: 10),
             Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                "Amount Given :",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                       fontSize: 23
                    ),
              ),
              Text(
                widget.amountGiven.toStringAsFixed(2),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: widget.amountGiven>=0? Colors.green: Colors.red,
                      fontSize: 23
                    ),
              ),
              ],
             ),
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                "Amount Borrowed : ",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                       fontSize: 23
                    ),
              ),
              Text(
                widget.amountBorrowed.toStringAsFixed(2),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: widget.amountBorrowed>=0? Colors.green: Colors.red,
                      fontSize: 23
                    ),
              ),
              ],
             ),
             
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
