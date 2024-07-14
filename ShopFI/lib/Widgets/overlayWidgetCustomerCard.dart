import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopfi/Providers/dataProvider.dart';

class OverlayWidgetCustomerCard extends ConsumerStatefulWidget {
  final Customer customer;
  final void Function() refresh;
  const OverlayWidgetCustomerCard(
      {required this.refresh, required this.customer, super.key});

  @override
  ConsumerState<OverlayWidgetCustomerCard> createState() =>
      _OverlayWidgetCustomerCardState();
}

class _OverlayWidgetCustomerCardState
    extends ConsumerState<OverlayWidgetCustomerCard> {
      final _formKey = GlobalKey<FormState>();
  var _textStorer;
  var _noteStorer;
  var _amountStorer;
  double? _amountDouble;
  DateTime selectedDate = DateTime.now();
  

  // Date backend
  void datepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var date = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      selectedDate = date!;
    });
  }

  void sumbitData() {
    if (_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      ref.watch(dataNotifierProvider.notifier).addCustomerData(
        context,
        widget.customer,
        CustomerData(
            date: selectedDate,
            amount:  _amountDouble!,
            title: _textStorer.trim(),
            note: _noteStorer.trim()));
    widget.refresh();
    Navigator.pop(context);
    }   
  }

  @override
  Widget build(BuildContext context) {
    var keyboard = MediaQuery.of(context).viewInsets.bottom;
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, keyboard + 15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    maxLength: 70,
                    decoration: InputDecoration(
                      label: Text(
                        "Title",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return "Please enter a valid Title";
                      } return null;
                    },
                    onSaved: (newValue){
                      _textStorer = newValue!;
                    },
                  ), // Title
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            prefixText: "\$",
                            label: Text(
                              "Amount",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        validator: (value){
                          if (value == null || value.isEmpty){
                            return "Please enter a valid amount";
                          } return null;
                        },
                        onSaved: ((newValue) {
                           
        _amountStorer = newValue ?? '0.0'; // Assign the string value directly
  _amountDouble = double.tryParse(_amountStorer) ?? 0.0; // Convert to double
                          
  }
                        ),
                        ),
                      ),
                      const SizedBox(width: 20), // Amount
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                          child: Row(
                            children: [
                              Text(
                                 DateFormat('dd/MM/yyyy').format(selectedDate).toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                              ),
                              const SizedBox(width: 2.0),
                              IconButton(
                                onPressed: datepicker,
                                icon: Icon(Icons.calendar_month,
                                    color: Theme.of(context).colorScheme.primary),
                              ),
                            ],
                          ),
                        ),
                      ) // Date
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      label: Text(
                        "Note",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                    onSaved: (newValue){
                      _noteStorer = newValue!;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: sumbitData,
                        style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary),
                        child: Text(
                          "Submit",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(width: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary),
                        child: Text(
                          "Cancel",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
