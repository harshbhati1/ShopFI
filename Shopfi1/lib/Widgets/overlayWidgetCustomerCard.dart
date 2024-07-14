import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopfi/Data/dataSchema.dart';

class OverlayWidgetCustomerCard extends StatefulWidget {
  final void Function(String functionName, CustomerData customerData) addCustomerDataCard;
  const OverlayWidgetCustomerCard({required this.addCustomerDataCard,super.key});

  @override
  State<OverlayWidgetCustomerCard> createState() => _OverlayWidgetCustomerCardState();
}

class _OverlayWidgetCustomerCardState extends State<OverlayWidgetCustomerCard> {
  DateTime? selectedDate;
 final _textController = TextEditingController();
 final _noteController = TextEditingController();
 final _amountController = TextEditingController();

 @override
  void dispose() {
    _textController.dispose();
    _noteController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // Date backend
  void datepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    var date = await showDatePicker(context: context, firstDate: firstDate, lastDate: now);
    setState(() {
      selectedDate = date;
    });
  }

  void sumbitData(){
    var amount = double.tryParse(_amountController.text);
    var isFalseAmount = amount == null || amount==0;

    if (_textController.text.trim().isEmpty || _noteController.text.trim().isEmpty || isFalseAmount || selectedDate==null){
      showDialog(context: context, builder: (context)=> AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text("Invalid Input", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground
        ),),
        content: Text("Please make sure you are entering valid title, amount, date and note!", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
          color: Theme.of(context).colorScheme.onBackground
        ),), 
        actions: [
          TextButton(onPressed: (){Navigator.of(context).pop();}, style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),child: Text("Okay", style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Theme.of(context).colorScheme.onPrimary
          ),))
        ],

      ));
      return;
    }
   widget.addCustomerDataCard("amountAdded",CustomerData(date: selectedDate!, amount: amount, title: _textController.text, note: _noteController.text));
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
                  controller: _textController,
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
                ), // Title
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white),
                        controller: _amountController,
                        decoration: InputDecoration(
                          prefixText: "\$",
                          label: Text(
                            "Amount",
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
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
                              selectedDate == null ? 'Select a date' : DateFormat('dd/MM/yyyy').format(selectedDate!),
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                            const SizedBox(width: 2.0),
                            IconButton(
                              onPressed: datepicker,
                              icon: Icon(Icons.calendar_month, color: Theme.of(context).colorScheme.primary),
                            ),
                          ],
                        ),
                      ),
                    ) // Date
                  ],
                ),
                const SizedBox(height: 10,),
                TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: _noteController,
                  decoration: InputDecoration(
                    label: Text(
                      "Note",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: sumbitData,
                      style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
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
                      style: TextButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.primary),
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
    );
  }
}
