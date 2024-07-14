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
  final _formKey = GlobalKey<FormState>();

  var _nameStorer;
  var _numberStorer;
  var _addressStorer;
  
  void sumbitData() {
    if (_formKey.currentState!.validate()){
       _formKey.currentState!.save();
       ref.watch(dataNotifierProvider.notifier).addCustomer(
        context,
        Customer(
            name: _nameStorer,
            number: _numberStorer,
            address: _addressStorer,
            customerData: []));
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
        child: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, keyboard + 15.0),
            child: Column(
              children: [
                TextFormField(
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
                  validator: (value) {
                    if (value == null || value.isEmpty){
                      return "Please enter a valid name";
                    } return null;
                  },
                  onSaved: (newValue) {
                    _nameStorer = newValue!;
                  },
                ),
                TextFormField(
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
                      validator: (value){
                        if (value == null || value.isEmpty){
                           return "Please enter a valid phone number";
                        } return null;
                      },
                      onSaved: (newValue) {
                    _numberStorer = int.parse(newValue!);
                  },
                      
                ),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  maxLength: 70,
                  decoration: InputDecoration(
                      label: Text(
                    "Address",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  )),
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "Please enter a valid address";
                    } return null;
                  },
                  onSaved: (newValue){
                    _addressStorer = newValue!;
                  },
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
        ),
      )),
    );
  }
}
