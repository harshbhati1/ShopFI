import 'package:flutter/material.dart';
import 'package:shopfi/Data/dataSchema.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopfi/Providers/dataProvider.dart';

class overlayWidgetCustomer extends ConsumerStatefulWidget {
  const overlayWidgetCustomer({super.key});

  @override
  ConsumerState<overlayWidgetCustomer> createState() =>
      _overlayWidgetCustomerState();
}

class _overlayWidgetCustomerState extends ConsumerState<overlayWidgetCustomer> {
  final _nameController = TextEditingController();
  final _numberController = TextEditingController();
  final _addressController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void sumbitData() {
    if (_nameController.text.trim().isEmpty ||
        _addressController.text.trim().isEmpty ||
        _numberController.text.trim().isEmpty) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Theme.of(context).colorScheme.background,
                title: Text(
                  "Invalid Input",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                content: Text(
                  "Please make sure you are entering valid name, phone number and address!",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      child: Text(
                        "Okay",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary),
                      ))
                ],
              ));
      return;
    }
    ref.watch(dataNotifierProvider.notifier).addCustomer(
        context,
        Customer(
            name: _nameController.text,
            number: int.tryParse(_numberController.text)!,
            address: _addressController.text,
            customerData: []));
    Navigator.pop(context);
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
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                style: const TextStyle(
                  color: Colors.white,
                ),
                maxLength: 30,
                decoration: InputDecoration(
                    label: Text(
                  "Name",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                )),
              ),
              TextField(
                controller: _numberController,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                maxLength: 10,
                decoration: InputDecoration(
                    prefixText: "+91 ",
                    label: Text(
                      "Phone Number ",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    )),
              ),
              TextField(
                controller: _addressController,
                style: const TextStyle(color: Colors.white),
                maxLength: 70,
                decoration: InputDecoration(
                    label: Text(
                  "Address",
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                )),
              ),
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
                      )),
                  const SizedBox(
                    width: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary),
                      child: Text(
                        "Cancel",
                        style: Theme.of(context).textTheme.titleLarge,
                      ))
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}
